#!/bin/bash
 

echo " this is the shell script for user moification"


echo " what do you want to do with the user?"
echo " 1. create a new user"
echo " 2. delete an existing user"
echo " 3. modify an existing user"
echo " 4. Backup"
echo " 5. Exit"

read -p "Enter your choice:(1 to 5)" choice
userChoice=$choice

if [ $userChoice -eq 1 ]; then
  echo "creating a new user"
  #p flag is used to prompt the user to enter the username
  read -p "enter the username:" username
  echo "you entered $username" 
  read -p " do you have any group name in mind? (y/n)" 
  newChoice =$choice
  if ["$choice" == "y"]; then
    read -p "enter the group name:" groupname
    usermod -a -G $groupname $username
  else
    read -p "enter a new group name to create:" newgroupname
    echo "creating a new group $newgroupname"
    groupadd $newgroupname
    usermod -a -G $newgroupname $username
  fi
  
elif [ $userChoice -eq 2 ]; then
  echo "deleting an existing user"
  read -p "enter the username to delete:" username
  userdel -r $username
  echo "user $username has been deleted"
  
elif [ $userChoice -eq 3 ]; then
  echo "modifying an existing user"
  read -p "enter the username to modify:" username
  read -p "enter the new username:" newusername
  usermod -l $newusername $username
  echo "username has been changed from $username to $newusername"
  
elif [ $userChoice -eq 4 ]; then
  echo "backup"
  read -p "enter the username to backup:" username
  read -p "enter the backup location:" backuplocation
  tar -cvf $backuplocation/$username.tar /home/$username
  echo "backup has been created"
  
elif [ $userChoice -eq 5 ]; then
  echo "exiting the script"
  exit 0
else
  echo "invalid choice"
  exit 1

fi 




