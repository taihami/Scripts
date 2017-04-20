#!/bin/bash

source printInColor.sh

$LAST_USER

printincolor info "\nPlease enter username of new user:\n"
#printf "Please enter username of new user:\n"
read -e username

#Use the adduser command to add a new user to your system
adduser $username

#Use the usermod command to add the user to the sudo group
#usermod -aG sudo $username

#Disable password requirements for this user when using sudo
echo "$username ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/$username
#echo "root ALL=($username) NOPASSWD:ALL" | tee -a /etc/sudoers
chmod 0440 /etc/sudoers.d/$username

#Use the su command to switch to the new user account
sudo -u $username -H sh -c "sudo ls -la /root"

#As the new user, verify that you can use sudo by prepending "sudo" to the command that you want to run with superuser privileges
#sudo ls -la /root

#Delete old user
printf "\nList of last 7 users:\n"

#used tail to truncate last 7 line
#used cut to remove everything after : in each line
tail -n 7 /etc/passwd | cut -d: -f1 

printincolor info "\nPlease enter username of user you want to delete:\n"
#printf "Please enter username of user you want to delete:\n"
read olduser

userdel $olduser

(tail -n 1 /etc/passwd | cut -d: -f1)>$LAST_USER
echo $LAST_USER

printincolor success "\nUser deleted successfully\n"
