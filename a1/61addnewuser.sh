#!/usr/bin/env bash
date
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# add new user. 
echo Usage 61addnewuser.sh  username 
echo

if [ $# -eq 0 ]; then
    echo "No arguments provided. "
    echo "Usage:  nuser.sh  username "
    exit 1
fi


#ask for password...

read -ep "Please enter the new users password: " pwnu1



nuser="$1"
echo user: "$nuser"
echo $pwnu1
#adduser asks questions and does more...
sudo adduser $nuser --gecos "$nuser,..,..,.." --disabled-password
echo "$nuser:$pwnu1" | sudo chpasswd
#add user to group www-data
sudo usermod -a -G www-data  $nuser
(echo "$pwnu1"; echo "$pwnu1") | sudo smbpasswd -s -a $nuser
sudo mkdir /home/$nuser/bin
sudo chown  $nuser:$nuser /home/$nuser/bin
#echo groups..
groups $nuser
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
date
#
