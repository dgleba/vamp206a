#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#  notes:

#  also refer to 61user.sh for more info.


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


nuser=albe

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


source ~/12settings.sh
source ~/safe/21env.sh

set -x

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#adduser asks questions and does more...
sudo /usr/sbin/adduser $nuser --gecos "david gleba,RM,wPhone,hPhone" --disabled-password
echo "$nuser:$pw27" |  sudo /usr/sbin/chpasswd
#sudo useradd -d /home/dg -m dg
#  no home dir... sudo useradd dg
#  sudo passwd dg
sudo /usr/sbin/usermod -a -G adm,dialout,plugdev,www-data,sudo,docker  $nuser
sudo chown -R $nuser:$nuser /home/$nuser

#sudo usermod -a -G sudo  dg

#sudo smbpasswd -a dg
#(echo $pw1; echo $pw1) | smbpasswd -s -a dg

sudo mkdir /home/$nuser/bin


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

groups
groups $userv
id $userv


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

offline()
{

# begin block comment =============================
: <<'END'
exit 999

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

END
# end block comment ===============================
}
#
