#!/usr/bin/env bash

set -x
source shc/21env.sh

cd

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# description:
# set samba shares and some linux user settings like immediate history write...


smb() {

source shc/root.sh
source shc/21env.sh


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




mkdir webwork
sudo mkdir -p /var/www/html


#backup server config...
mkdir ~/backup
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bk$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
sudo cp /etc/samba/smb.conf    ~backup/smb.conf.bk$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")


sudo cat <<EOF >> /etc/samba/smb.conf
# -------------------------------------------------------------------
# shares
#
#
[home]
path = /home/$userv
browsable =yes
writable = yes
guest ok = no
read only = no
valid users = $userv
# sudo smbpasswd -a $userv
# http://www.cyberciti.biz/tips/how-do-i-set-permissions-to-samba-shares.html
# https://www.howtoforge.com/samba-server-ubuntu-14.04-lts
#
EOF


}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
saynow() {
date
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

saynow
set -x
smb
date



#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

saynow 
{
# this function not used.
echo (date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
}

offlinestuff()  {
echo tmp1
}


saynow
#

