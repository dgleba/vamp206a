#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#
#
#
#  This file sets some initial settings  
#
#  2018-06-11 turned off samba share as I am using filzilla over ssh.
#
#

# copy vne.sh over. IT is where I edit 21env.sh for my personal settings...
mkdir -p tmp01
mkdir -p safe
chmod -R 700 safe/ 

sudo mkdir -p /tmp01/tempfiles
sudo chmod -R 700 tmp01
sudo chmod -R 700 /tmp01/tempfiles
sudo chown -R  "${userv}"  tmp01 

sudo groupadd www-data

#copy env supplied with package first..
cp shc/a3/21env.sh safe/21env.sh

# then overwrite it with mine. Which won't happen if it's not there.
cp safe/vne.sh safe/21env.sh


source shc/root.sh
set +vx
source /home/$userv/safe/21env.sh
set -vx


#~~~~~~

file1="shc/a2/21env.sh"
# back it up with a unique name using a timestamp..
cp -a $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt


#~~~~~~

#note...
#    if this is run more than once, it will duplicate entries...
#

#~~~~
# description:
# set samba shares and some linux user settings like immediate history write...

# put other things to run once here too..  see onetime1()

#~~~~

#get a few software to help get things started...   # moved to netson.seed
sudo apt-get update
#sudo apt-get -y install openssh-server 
sudo apt-get -y install p7zip-full
sudo apt-get -y install unzip 
sudo apt-get -y install mc
sudo apt-get -y install locate acl make
sudo apt -y install build-essential

#sudo apt-get -y install curl libcurl3 libcurl3-dev php5-curl


echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections

sudo apt-get -y install iptables-persistent

# You can verify these fields by installing debconf-utils and searching for iptables values:
sudo apt -y install debconf-utils
sudo debconf-get-selections | grep iptables




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# Functions...



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function runsam() {

sudo apt-get update

sudo mkdir -p /var/www/html

sudo apt-get -y install samba cifs-utils

#backup server config...
mkdir ~/backup
# backup original file once...
if [ ! -f /etc/samba/smb.conf.orig ] ; then  sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.orig ; fi
#
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bk.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z").txt
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.$(date +"%s").bk
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.$(date +"%Y-%m-%d_%s").bk.txt
sudo cp /etc/samba/smb.conf    ~/backup/smb.conf.bk.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z").bk.txt
## one time fix... sudo cp /etc/samba/smb.conf.bk__2015-10-22_Thu_15.08.24-EDT /etc/samba/smb.conf.orig

#copy the original file backup I made at the beginning so we get a fresh start..
cp /etc/samba/smb.conf.orig /etc/samba/smb.conf

#~~~

# cat /etc/samba/smb.conf |grep global

# remove line containing  '[global]'  and replace th line completely with the new text...
# add marker line above my edits... 
# add a marker comment like: #David Gleba 2015-10-16... http://stackoverflow.com/questions/11694980/using-sed-insert-a-line-below-or-above-the-pattern
# now replace the line... http://stackoverflow.com/questions/16440377/sed-replace-whole-line-when-match-found
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo sed -i "/global]/i # \n# David Gleba kdg54 $nowdg1 invalid handle error, add unixextensions=no. see see vamp,samba,error,notes-2016-05-09.txt ...\n#"  /etc/samba/smb.conf 
sudo sed -i 's/.*global].*/[global]\n\nunix extensions = no/g' /etc/samba/smb.conf 



#~~~~



sudo cat <<EOF >> /etc/samba/smb.conf 

# -------------------------------------------
# shares
#
# [home]
# path = /home
# browsable =yes
# writable = no
# guest ok = no
# read only = no
# valid users = $userv,@www-data
# #
# [homefile]
# path = /home/file
# browsable =yes
# writable = no
# guest ok = no
# read only = no
# valid users = ftpup
#
#[html]
#path = /var/www/html
#browsable =yes
#writable = yes
#guest ok = no
#read only = no
#valid users = $userv,@www-data
#force user
#force group
## create mask = 6770   http://permissions-calculator.org/  7770 is setuid, setgid, stickybit, rwxrwx--- 
#create mask = 7770
#directory mask = 6771
##
#[rt]
#path = /
##due to invalid handle error. add widelinks=yes. see vamp,samba,error,notes-2016-05-09.txt
#wide links = yes
#browsable =yes
#writable = yes
#guest ok = no
#read only = no
#valid users = $userv,@www-data
#force user
#force group
## create mask = 6770   http://permissions-calculator.org/  7770 is setuid, setgid, stickybit, rwxrwx--- 
#create mask = 7770
#directory mask = 6771
#
# sudo smbpasswd -a $userv
# http://www.cyberciti.biz/tips/how-do-i-set-permissions-to-samba-shares.html
# https://www.howtoforge.com/samba-server-ubuntu-14.04-lts
#
EOF



#~~~~



source safe/21env.sh
#sudo smbpasswd -a $userv 
# set password silently - answers supplied by script..
(echo $pw1; echo $pw1) | sudo smbpasswd -s -a $userv




#~~~~~~~~~~~
#2016-05-15
#http://unix.stackexchange.com/questions/214128/samba-specified-network-name-no-longer-available
#Sometimes Samba fails to install or update it's dependencies correctly. Try running the following command to ensure all the dependencies are available, this is on Ubuntu, modify for your Linux flavour:
sudo apt-get -y install --reinstall libsmbclient libsmbclient-dev libtevent0 libtalloc2

#worked!

sudo sudo service smbd restart

}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function onetime1() {


source shc/a3/alias21.sh


}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


rsnap() {

mkdir -p  $HOME/bin/
cp shc/bin1/histb.sh  $HOME/bin/
source bin/histb.sh
sudo mkdir -p /var/www/html


sudo apt -y install ncdu rsnapshot 


# get copy of /etc/rsnapshot.conf for editing.
cd
file1="/etc/rsnapshot.conf"
sudo cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt     # do you need sudo cp?
mkdir ~/work
cp $file1 work/

sudo cp shc/a3/rsnapshot.conf /etc

# sudo rsnapshot alpha     # run this to make the first backup.

}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


main() {

sudo sudo service smbd restart

#~~~~~~
#if this has run before, then exit...
if [ -f /home/$userv/15ran ]; then
    # 15run exists, so don't run this again. exit.
    echo
    echo "15samsh.sh has run before, don't run again."
    echo
    read -t  19 -p "Hit ENTER or wait about ten seconds" ; echo ;

 else
    echo "run it... 15samsh.sh "
    #
    #   turned off..         runsam         # turned this off 2018-06-11 
    #
    onetime1
    rsnap
    cd
    # create 15ran to mark that is has been run. Then don't run it again.
    touch /home/$userv/15ran
 fi

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



set -x
main
date
#
