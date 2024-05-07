#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

source safe/21env.sh
set -vx
cd


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# check for interactive shell
if ! grep -q "noninteractive" /proc/cmdline ; then
    stty sane

#  ask questions
#    read -ep " please enter the username you are currently logged in as: " -i "$userv" userv
#    read -ep " please enter your preferred hostname: " -i "$default_hostname" hostname
#    read -ep " please enter your preferred domain: " -i "$default_domain" domain
  
fi

# print status message
echo " preparing your server; this may take a few minutes ..."


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# update repos
#
apt-get -y update 
# update / upgrade
#apt-get -y upgrade > /dev/null 2>&1
#
# unattended upgrade?? http://askubuntu.com/questions/250733/can-i-do-a-silent-or-unattended-release-upgrade
#apt-get -y dist-upgrade > /dev/null 2>&1
#sudo apt-get update
#sudo apt-get -y upgrade
apt-get -y autoremove 
apt-get -y purge 


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

apt-get -y install mc
apt-get -y install locate
apt-get -y install openssh-server 
apt-get -y install samba
#apt-get -y install apache2  
#apt-get -y install php5 
apt-get -y install cifs-utils 

#backup ssh server config...
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bk$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.$(date +"%Y.%m.%d_%k.%M.%S").bk

cd
cp shc/bin1/* bin


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function temp22() {
echo
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
