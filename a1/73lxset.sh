#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd
source shc/21env.sh

# echo off
set +vx
# echo on
set -vx

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# import my lxde settings from archive tgz

# backup user home dir ...
sudo tar -cvzf backup/$userv-home.$(date +"%Y.%m.%d_%k.%M.%S").tgz  /home/$userv/ --exclude={tmp01,backup,Trash/files,backup/*.tgz} 
# create lxde settings file...
sudo tar -cvzf backup/$userv-lxdeset2.$(date +"%Y.%m.%d_%k.%M.%S").tgz  /home/$userv/ --exclude={.dbus,Downloads,.local,Music,Pictures,Templates,.thumbnails,Videos,tmp,.gconf,Public,.vnc,.mozilla,shc,.cache,tmp01,backup,Trash/files,backup/*.tgz} 
# this seems to take just the files in the home folder without any directories and then add folder like .config, bin, Desktop.
#  http://unix.stackexchange.com/questions/24870/tar-files-only-no-directories
cd
find . -maxdepth 1 -type f -print0 | tar cvzf backup/lxdeset3_$userv_home.$(date +"%Y.%m.%d_%k.%M.%S").tgz .config bin Desktop --exclude={15ran,11get.sh} --null -T -



#to get it from ftp...
if  [ 1 = 0 ] ; then
    cd tmp01
        if ping -c 1 192.168.88.94 &> /dev/null
        then
          curl -O -u dg:fruit ftp://192.168.88.94:2141//files/lxdehome.tgz
        else
          curl -O -u dg:fruit ftp://10.4.10.243:2141//files/lxdehome.tgz
        fi
    cd 
    tar -xvf tmp01/lxdehome.tgz
fi

# if it was retreived from the repo already...
if  [ 1 = 1 ] ; then
    cd 
    tar -xvf shc/lxdehome.tgz
fi


   
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
exit 999

#create home backup for unpacking with lxset.sh...
# need .config desktop some .files in home/ubuntuUser...
#tar -cvzf lxdehome.tgz .


_____________


error:
http://askubuntu.com/questions/452108/cannot-change-screen-size-from-640x480-after-14-04-installation-on-virtualbox-os

i changed the memory size and then could not change the screen size...

sudo apt-get install virtualbox-guest-dkms

this fixed it.

2015-12-07_Mon_14.26-PM

_____________


}
#