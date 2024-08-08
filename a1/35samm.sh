#!/usr/bin/env bash
cd
source shc/21env.sh

# purpose: mount windows shares on linux machine...

smbmn() {

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#edit these lines to match your windows machines shares...
#

# try this, it worked by manual editing..  2016-02-01_Mon_13.33-PM


sudo cat <<EOF >> /etc/fstab
# David Gleba 
//192.168.88.64/home /mnt/REDEK210/home cifs credentials=/home/albe/.smbcredredek210,iocharset=utf8,sec=ntlm 0 0 
#
EOF
#
sudo mkdir -p /mnt/REDEK210/home
sudo chmod 755 /mnt/REDEK210/home
#
tee ~./smbcredredek210 <<EOF
username=albe
password=agoodpassword
EOF
chmod 600 ~/.smbcredentials
sudo mount -a

}




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

offlines-notes() {

# begin block comment =============================
: <<'END'

date
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2016-02-01[Feb-Mon]11-58AM

Mount password protected network folders - smb

The quickest way to auto-mounting a password-protected share is to edit /etc/fstab (with root privileges), to add this line:
//servername/sharename  /media/windowsshare  cifs  username=msusername,password=mspassword,iocharset=utf8,sec=ntlm  0  0
This is not a good idea however: /etc/fstab is readable by everyone and so is your Windows password in it. The way around this is to use a credentials file. This is a file that contains just the username and password.

Using a text editor, create a file for your remote servers logon credential:

gedit ~/.smbcredentials
Enter your Windows username and password in the file:

username=msusername
password=mspassword

Save the file, exit the editor.

Change the permissions of the file to prevent unwanted access to your credentials:

chmod 600 ~/.smbcredentials
Then edit your /etc/fstab file (with root privileges) to add this line (replacing the insecure line in the example above, if you added it):

//servername/sharename /media/windowsshare cifs credentials=/home/ubuntuusername/.smbcredentials,iocharset=utf8,sec=ntlm 0 0 
Save the file, exit the editor.

Finally, test the fstab entry by issuing:
sudo mount -a
If there are no errors, you should test how it works after a reboot. Your remote share should mount automatically.

=

worked:

sudo leafpad /etc/fstab

//192.168.88.64/home /mnt/REDEK210/home cifs credentials=/home/albe/.smbcredentials,iocharset=utf8,sec=ntlm 0 0 
#

sudo mkdir -p /mnt/REDEK210/home
sudo chmod 755 /mnt/REDEK210/home

leafpad ~./smbcredentials
username=albe
password=

chmod 600 ~/.smbcredentials
sudo mount -a

_____________


https://wiki.ubuntu.com/MountWindowsSharesPermanently


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

END
# end block comment ===============================

}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set -x
smbmn
date
