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
nuser="$1"

echo $pwnu1
#adduser asks questions and does more...
sudo adduser $nuser --gecos "$nuser,..,..,.." --disabled-password
echo "$nuser:$pwnu1" | sudo chpasswd

#add user to group www
# sudo usermod -a -G sambashare  $nuser

while true; do
    read -p "Do you wish to add this user to www-data  and docker group?" yn
    case $yn in
        [Yy]* ) sudo usermod -a -G www-data $nuser; sudo usermod -a -G docker  $nuser; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


# (echo "$pwnu1"; echo "$pwnu1") | sudo smbpasswd -s -a $nuser
# sudo mkdir /home/$nuser/bin
# sudo chown  $nuser:$nuser /home/$nuser/bin

echo " "
echo server hostname: $HOSTNAME
echo user: "$nuser"
echo password: "$pwnu1"
echo groups:
groups $nuser
id $nuser
echo "Access the server using apps that use ssh access like:   cyberduck, ssh, mremoteng, filezilla etc.."

# show smb users..
# sudo pdbedit -L -v

echo ""
echo "sudo adduser username sudo  - to add user to sudo"
echo ""


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# remove user from a group
#       sudo gpasswd -d username group
#
# add a user..
# nuser=albe
# sudo adduser $nuser --gecos "$nuser,..,..,.."
# sudo usermod -a -G sudo  $nuser
#
#
#  hmm. why useradd? is this to add a user and to groups to?  
#    nuser=duser
#    sudo useradd -m  -G docker,www-data,sudo  $nuser
#    id $nuser
#    sudo passwd $nuser
#
# add user to a group.
#  
#   nuser=albe&&  sudo usermod -a -G docker  $nuser; 
#
#
#  adminuser reguser
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


date
#
