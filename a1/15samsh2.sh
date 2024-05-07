#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

cd

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# description:
# set samba shares for /home/file so data can be copied there for import to db. 2017-07-28
#    changing shares to restrict them due to 'bit paymer' ransomeware 2017-07-28.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#note...
#    if this is run more than once, it will duplicate entries...
#

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set +vx 
source shc/21env.sh
set -vx
source shc/root.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function runsam() {

#backup server config...
mkdir ~/backup
# backup original file once...
if [ ! -f /etc/samba/smb.conf.orig ] ; then  sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.orig ; fi
#
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bk.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z").txt
sudo cp /etc/samba/smb.conf    ~/backup/smb.conf.bk.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z").bk.txt
## one time fix... sudo cp /etc/samba/smb.conf.bk__2015-10-22_Thu_15.08.24-EDT /etc/samba/smb.conf.orig



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


sudo cat <<EOF >> /etc/samba/smb.conf 
# -------------------------------------------------------------------
# -------------------------------------------------------------------
# shares
#
# https://askubuntu.com/questions/97669/i-cant-get-samba-to-set-proper-permissions-on-created-directories
#
[home]
path = /home
browsable =yes
writable = yes
guest ok = no
read only = no

# 2017-07-30 working permissions settings. Need unix extensions = no.
create mask = 2660
force create mode = 2660
directory mask = 02771
force directory mode = 02771

# not working..
#  create mask = 2770
#  force create mode 2770
#  security mask = 2770
#  force security mode = 2770
#  directory mask = 2771
#  force directory mode = 2771
#  directory security mask = 2771
#  force directory security mask = 2771

#was this, try without dgleba... valid users = ubuntuUser,dgleba,@www
valid users = ftpup
#
#
[homefile]
path = /home/file
browsable =yes
writable = yes
guest ok = no
read only = no
#was this, try without dgleba... valid users = $userv,dgleba,@www
valid users = ftpup,@ftp
create mask = 7770
directory mask = 6771
#
EOF


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#add user ftp to this share to copy files for import to db...

#sudo adduser ftpup --gecos "ftp uploader user,0,0,0" --disabled-password
#echo "ftpup:$pw2" | sudo chpasswd
#sudo mkdir /home/file
#sudo chmod 755 -R /home/file

sudo usermod -a -G sambashare,ftp  ftpup
groups ftpup

# samba password..
(echo "$pw2"; echo "$pw2") | sudo smbpasswd -s -a ftpup

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# setfacl..



#mkdir tech
#chown root:tech tech/
#chmod g+s tech/
#chmod 0750 tech/
#setfacl -d -m g:techAdmin:rwx tech/
#setfacl -m group:techadmin:rwx tech/ - not sure why this needed to be there as the above code I though would take care of it.  if anyone knows why, please post in the comments.
# http://permissions-calculator.org/
# https://www.cyberciti.biz/tips/understanding-linux-unix-umask-value-usage.html
# 2017-07-28_Fri_15.31-PM: also consider..  /etc/login.defs has UMASK		022

#remove acl
#  sudo setfacl -R -b  /home/file

# add acl
sudo setfacl -R -m group:ftp:rwx /home/file/import1
sudo setfacl -R -m group:ftp:rwx /home/file/cmm
sudo setfacl -R -m group:ftp:rwx /home/file/cmmtmp
sudo setfacl -m group:ftp:rx /home/file
getfacl /home/file/import1



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo sudo service smbd restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

}


set -x
runsam
date
set +x
#

