#!/bin/bash
 
echo "This is the shell script for user modification"

echo "What do you want to do with the user?"
echo "1. Create a new user"
echo "2. Delete an existing user"
echo "3. Modify an existing user"
echo "4. Backup"
echo "5. Exit"

read -p "Enter your choice (1 to 5): " userChoice

if [ $userChoice -eq 1 ]; then
  echo "Creating a new user"
  read -p "Enter the username: " username
  echo "You entered $username" 
  read -p "Do you have any group name in mind? (y/n): " newChoice
  if [ "$newChoice" == "y" ]; then
    read -p "Enter the group name: " groupname
    usermod -a -G "$groupname" "$username"
  else
    read -p "Enter a new group name to create: " newgroupname
    echo "Creating a new group $newgroupname"
    sudo groupadd "$newgroupname"
    sudo usermod -a -G "$newgroupname" "$username"
  fi
  
elif [ $userChoice -eq 2 ]; then
  echo "Deleting an existing user"
  read -p "Enter the username to delete: " username
  if id "$username" &>/dev/null; then
    sudo userdel -r "$username"
    echo "User $username has been deleted"
  else
    echo "User $username does not exist"
    exit 1
  fi
  
elif [ $userChoice -eq 3 ]; then
  echo "Modifying an existing user"
  read -p "Enter the username to modify: " username
  if id "$username" &>/dev/null; then
    read -p "Enter the new username: " newusername
    usermod -l "$newusername" "$username"
    echo "Username has been changed from $username to $newusername"
  else
    echo "User $username does not exist"
    exit 1
  fi
  
elif [ $userChoice -eq 4 ]; then
  echo "Backup"
  read -p "Enter the username to backup: " username
  if id "$username" &>/dev/null; then
    read -p "Enter the backup location: " backuplocation
    mkdir -p "$backuplocation"
    tar -cvf "$backuplocation/$username.tar" "/home/$username"
    echo "Backup has been created"
  else
    echo "User $username does not exist"
    exit 1
  fi
  
elif [ $userChoice -eq 5 ]; then
  echo "Exiting the script"
  exit 0

else
  echo "Invalid choice"
  exit 1
fi
