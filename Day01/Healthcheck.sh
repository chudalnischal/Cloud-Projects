#!/bin/bash 

# This script is used to check the health of the server

echo "Menu"
echo "1. Check the disk space"      
echo "2. Check the memory"
echo "3. Access Memory Usage"
echo "4. Check the CPU Usage"
echo "6. Sending the report via email"
echo "7. Exit"

echo "Enter your choice"    
read choice

if [ $choice -eq 1 ]
then
    df -h
elif [ $choice -eq 2 ]
then
    ps -aux
elif [ $choice -eq 3 ]
then
    free -m
elif [ $choice -eq 4 ]
then
    mpstat
elif [ $choice -eq 5 ]
then
    echo "Enter the email address"
    read email
    echo "Enter the subject"
    read subject
    echo "Enter the message"
    read message
    echo "Enter the attachment"
    read attachment
    echo "Sending the email"
    echo $message | mail -s $subject $email -A $attachment
elif [ $choice -eq 6 ]
then
    exit
else
    echo "Invalid choice"
fi
