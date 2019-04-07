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
cp shc/a2/21env.sh safe/21env.sh

# then overwrite it with mine. Which won't happen if it's not there.
cp safe/vne.sh safe/21env.sh


source shc/root.sh
set +vx
source safe/21env.sh
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
# sudo apt-get -y install openssh-server p7zip-full unzip locate acl make
sudo apt-get -y install mc
# sudo apt-get -y install curl libcurl3 libcurl3-dev php5-curl


echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections

sudo apt-get -y install iptables-persistent

# You can verify these fields by installing debconf-utils and searching for iptables values:
sudo apt install debconf-utils
sudo debconf-get-selections | grep iptables



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# Functions...



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function onetime1() {


source shc/a3/alias21.sh


sudo apt -y install build-essential


# add ~/bin to path..
mkdir -p ~/bin
PATH="$PATH:$HOME/bin"
sudo cat <<EOF >> $HOME/.bashrc
# -------------------------------------------------------------------
#
PATH="$PATH:$HOME/bin"
#
EOF


}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


main() {


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
    #rsnap
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
