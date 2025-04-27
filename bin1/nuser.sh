#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

date
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# add new user. 
echo Usage nuser.sh  username 
echo

if [ $# -eq 0 ]; then
    echo "No arguments provided - specify username"
    exit 1
fi

read -ep "Please enter the new users password: " pwnu1
userv="$1"

echo $pwnu1
#adduser asks questions and does more...
sudo adduser $userv --gecos "$userv,..,..,.." --disabled-password;
echo "$userv:$pwnu1" | sudo chpasswd;
# set default group..
sudo usermod -g staff $userv;


#add user to group www
# sudo usermod -a -G sambashare  $userv

while true; do
    read -p "Do you wish to add this user to www-data,  and docker group?" yn
    case $yn in
        [Yy]* ) sudo usermod -a -G www-data $userv; sudo usermod -a -G docker  $userv; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


# (echo "$pwnu1"; echo "$pwnu1") | sudo smbpasswd -s -a $userv
# sudo mkdir /home/$userv/bin
# sudo chown  $userv:$userv /home/$userv/bin

echo " "
echo server hostname: $HOSTNAME
echo user: "$userv"
echo password: "$pwnu1"
echo groups:
groups $userv
id $userv
echo "Access the server using apps that use ssh access like:   cyberduck, ssh, mremoteng, filezilla etc.."

# show smb users..
# sudo pdbedit -L -v

echo ""
echo "sudo adduser username sudo  - to add user to sudo"
echo ""


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# remove user from a group
#       sudo gpasswd -d userb sudo
#
# add a user..
# userv=albe
# sudo adduser $userv --gecos "$userv,..,..,.."
# sudo usermod -a -G sudo  $userv
#
#
#  create user..  
#    user2=userb
#    sudo useradd -m  -G staff,docker,www-data  $user2
#    sudo usermod -g staff $user2;
#    id $user2
#    sudo passwd $user2
#
# add user to a group.
#  
#   userv=userb &&  sudo usermod -aG docker  $userv; 
#
#
#  adminuser  userb 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


date
#
