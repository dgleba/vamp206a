#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#  notes:

# use `nuser.sh` to interactively add a user after this.  (this was 61addnewuser.sh)

#  use www-data group.  don't:  add `www` group and a user.
#  also refer to 61user.sh for more info.


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

. ~/12settings.sh

set -x

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#adduser asks questions and does more...
sudo /usr/sbin/adduser albe --gecos "david gleba,RM,wPhone,hPhone" --disabled-password
echo "dg:$pw27" |  sudo /usr/sbin/chpasswd
#sudo useradd -d /home/dg -m dg
#  no home dir... sudo useradd dg
#  sudo passwd dg
sudo /usr/sbin/usermod -a -G adm,dialout,plugdev,www-data  albe
#sudo usermod -a -G sudo  dg

#sudo smbpasswd -a dg
#(echo $pw1; echo $pw1) | smbpasswd -s -a dg



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