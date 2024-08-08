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

set -x

export pw1=a

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#adduser asks questions and does more...
/usr/sbin/adduser dg --gecos "david gleba,RM,wPhone,hPhone" --disabled-password
echo "dg:$pw1" |  /usr/sbin/chpasswd
#sudo useradd -d /home/dg -m dg
#  no home dir... sudo useradd dg
#  sudo passwd dg
/usr/sbin/usermod -a -G adm,dialout,plugdev,www-data  dg
#sudo usermod -a -G sudo  dg

#sudo smbpasswd -a dg
#(echo $pw1; echo $pw1) | smbpasswd -s -a dg



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#   see nuser.sh

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

:stuff to manage user on windows...

net use \\VAMP206B\ /delete

net use \\pmdsdata3\ /delete

net use * /delete

:net use \\SERVER * /user:username
net use \\vamp206b * /user:dgleba
net use \\pmdsdata3 * /user:dgleba


http://superuser.com/questions/123833/how-do-i-change-the-user-i-am-logged-in-with-on-a-network-share
net use \\SERVER * /user:username
net use \\pmdsdata3 * /user:ubuntuUser
***  error..........     System error 1219 has occurred.

worked:
rundll32.exe keymgr.dll, KRShowKeyMgr

not-worked?:
Control panel - User Accounts and Family Safety.
(Click your image in the start menu, or navigate through control panel).
In the left hand side panel, select Manage your credentials.
Under Windows Credentials:
maybe...
delete the credential for the computer with the smb share...
logout and log back in?

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# remove user from a group
#       sudo gpasswd -d username group
sudo gpasswd -d dgleba sudo
sudo gpasswd -d dclark sudo
sudo gpasswd -d cstrutton sudo

# list sudoers..
grep -Po '^sudo.+:\K.*$' /etc/group


noworky... usermod -R "group" "user name"
    usermod -R sudo dgleba

sudo usermod -a -G www-data,sudo  nina

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



END
# end block comment ===============================
}
#