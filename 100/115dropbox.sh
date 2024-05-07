#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# netbeans and git cola git eye install..

sudo apt-get -f install
sudo apt-get install python-gtk2 python-cairo  python-gobject-2
cd ~ && cd tmp
#wget -N "https://www.dropbox.com/download?plat=lnx.x86_64"
#sudo dpkg -i /home/albe/tmp/dropbox_2015.10.28_amd64.deb

#albe@vamp206b:~/tmp$ sudo dpkg -i /home/albe/tmp/dropbox_2015.10.28_amd64.deb
#dpkg: error processing archive /home/albe/tmp/dropbox_2015.10.28_amd64.deb (--install):  cannot access archive: No such file or directory
#Errors were encountered while processing: /home/albe/tmp/dropbox_2015.10.28_amd64.deb

cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd

#albe@vamp206b:~$ ~/.dropbox-dist/dropboxd
#Couldn't start Dropbox.
#This is usually because of a permissions error. Storing your home folder on a network share can also cause an error.
#Get more help at https://www.dropbox.com/c/help/permissions_error
#Please contact Dropbox support with the following info for help:

export LC_ALL=C
#http://askubuntu.com/questions/477425/how-to-install-dropbox-on-ubuntu-14-server-gui-less
env - LANG="$LANG" ~/.dropbox-dist/dropboxd &

#This computer isn't linked to any Dropbox account...
#Please visit https://www.dropbox.com/cli_link_nonce?nonce=5c4d43f93c3c5f8a78a683e6d1530a2d to link this device.

cd bin
wget -O dbx.py https://www.dropbox.com/download?dl=packages/dropbox.py
chmod +x dbx.py
cd 
dbx.py exclude add photos
dbx.py lansync y
dbx.py autostart y



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
exit 999

# begin block comment =============================
: <<'END'

END
# end block comment ===============================

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#

