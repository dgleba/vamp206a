#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd
source shc/21env.sh
set -vx

# purpose: mount windows shares on linux machine...
# good luck, you will need it...

#2015-10-28
#can't mount using cmdline. can mount with pcmanfm on smb://PMDS-3HZGD42/C using dgleba domain=stackpole password


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


smbmn() {

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#edit these lines to match your windows machines shares...
#
sudo apt-get -y install smbclient



#get ip address of windows machine...
#ipredwe=$(ping -c 1 REDWE | grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'  | head -n1)
ipredwe=nmblookup -S REDWE | grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'  | head -n1
echo "$ipredwe"

sudo mkdir -p /mnt/REDWE//c
sudo chmod -R 777 /mnt/REDWE/c
#sudo chmod -R 777 ~/webwork

# this is a share for drive c - the whole drive
sudo mount -t cifs //$ipredwe/c /mnt/REDWE/c -o username=$uredwe,password=$predwe
sudo mount -t cifs //redwe/c /mnt/REDWE/c -o username=$uredwe,password=$predwe

# this is a share where the web root files are..
mkdir -p /var/www/html
sudo mount -t cifs //$ipredwe/htocs /var/www/html -o username=$uredwe,password=$predwe

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#http://unix.stackexchange.com/questions/124342/mount-error-13-permission-denied
#
mkdir -p /home/$userv/.config/.smb
sudo cat <<EOF > /home/$userv/.smbc
username=$u3hz
password=$p3hz
domain=stackpole
EOF
chmod go-rwx /home/$userv/.smbc
#cat ~/smbcredc

#get ip address of windows machine...
#notgood...  ip3hz = nmblookup -S PMDS-3HZGD42 | grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'  | head -n1
ip3hz1=$(ping -c 1 PMDS-3HZGD42 | grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'  | head -n1)
echo "$ip3hz1"
export ip3hz="$ip3hz1"

sudo mkdir -p /mnt/3hz/C
sudo chmod -R 777 /mnt/3hz/C
# this is a share for drive c - the whole drive
#sudo mount -t cifs //$ip3hz/c /mnt/3hz/c -o username=$u3hz,password=$p3hz
#sudo mount -t cifs //$ip3hz/C /mnt/3hz/C -o domain=stackpole.com,username=$u3hz,password=$p3hz
#sudo mount -t cifs //PMDS-3HZGD42/C /mnt/3hz/C -o domain=stackpole.com,username=$u3hz,password=$p3hz
sudo mount -v -t cifs //PMDS-3HZGD42/C /mnt/3hz/C -o credentials=/home/$userv/.smbc



# this is a share where the web root files are..
sudo mkdir -p /var/www/html
sudo mkdir -p /mnt/3hz/htdocs
# this needs improvement.. need to check for a file there to ensure it's not mounted before doing this chmod...
chmod -R 777 /mnt/3hz/htdocs
#sudo mount -t cifs //10.4.10.243/htdocs /mnt/3hz/htdocs -o username=dgleba,password=x
#sudo mount -t cifs //$ip3hz/htdocs /mnt/3hz/htdocs -o username=$u3hz,password=$p3hz
#sudo mount -t cifs //$ip3hz/htdocs /mnt/3hz/htdocs -o domain=stackpole,username=$u3hz,password=$p3hz
#worked:
sudo mount -v -t cifs //PMDS-3HZGD42/htdocs /mnt/3hz/htdocs  -o credentials=/home/$userv/.smbc



}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function smbcl() {

# list smb shares in the network

sudo apt-get install smbclient

smbclient -L redwe
smbclient -L redex164

10.4.10.243 PMDS-3HZGD42
#chmod 755 smbcredc
smbclient -L -v 10.4.10.243  -A=.smbcredc
smbclient -L PMDS-3HZGD42  -A=smbcredc

ubuntuUser@pmdsdata3:~$ smbclient -L 10.4.10.243  -A=smbcredc
session setup failed: NT_STATUS_LOGON_FAILURE


smbtree

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function umntinfo() 
{
http://stackoverflow.com/questions/74626/how-do-you-force-a-cifs-connection-to-unmount
umount -l
sudo umount -a -t cifs -l
#??  sudo umount -u /mnt/3hz/htdocs
umount /mnt
umount /mnt/3hz/htdocs


}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

offlines-notes() {

# begin block comment =============================
: <<'END'

date
exit 999


firewall at csd may be preventing...
apt-get install smbclient...
Failed to fetch http://archive.ubuntu.com/ubuntu/pool/main/s/samba/smbclient_4.1.6+dfsg-1ubuntu2.14.04.9_amd64.deb  Size mismatch


smb://PMDS-3HZGD42/C
smb://dgleba@PMDS-3HZGD42/C
works.
smb://stackpole;dgleba@PMDS-3HZGD42/C
worked...
smb://stackpole;dgleba@pmds-3hzgd42/c/0

noworks.
smb://stackpole.com;dgleba:a@PMDS-3HZGD42/C
smb://stackpole.com;dgleba@PMDS-3HZGD42/C

#smb://DOM%5Cabcdefg@server.tld/server/path   (%5C is the URL encoding of the backslash character)


smb://WORKGROUP;User@machine.somewhere.com/Share
http://superuser.com/questions/145390/entering-domain-information-when-connecting-to-samba-share-in-dolphin
http://hints.macworld.com/article.php?story=20031203172256827
http://superuser.com/questions/344775/passing-unc-username-and-password-within-a-unc-path

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
get ipaddress

#gives : ..  10.4.11.10:
ping -c 1 st-dgleba | grep "64 bytes from"|awk '{print $4}'
#hmm. it always has a colon... this doens't work...
ping -c 1 st-dgleba2 | awk -F'[ :]' 'NR==2 { print $4 }'
#good..
ping -c 1 st-dgleba | grep "64 bytes from " | awk '{print $4}' | cut -d":" -f1

#good:
ping -c 1 st-dgleba | awk -F" |:" '/from/{print $4}'
#works..
ipa21=$(ping -c 1 st-dgleba | awk -F" |:" '/from/{print $4}')
echo $ipa21
#but..
# this returned pmds-jpruim-vm1.stackpole.ca from 64 bytes from pmds-jpruim-vm1.stackpole.ca (10.4.10.243): icmp_seq=1 ttl=128 time=1.11 ms
#ip3hz=$(ping -c 1 PMDS-3HZGD42 | awk -F" |:" '/from/{print $4}')
echo "$ip3hz"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-30[Oct-Fri]10-09AM

sudo cat <<EOF > ~/smbcred
username=dgleba
password=$p3hz
domain=stackpole
EOF

sudo mount -v -t cifs //PMDS-3HZGD42/htdocs /mnt/3hz/htdocs  -o credentials=~/smbcred

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-10-30[Oct-Fri]11-08AM

it was mounted, doing it again...
.. yet it got an error...

+ sudo mount -v -t cifs //PMDS-3HZGD42/htdocs /mnt/3hz/htdocs -o credentials=/home/ubuntuUser/.smbc
domain=stackpole
mount.cifs kernel mount options: ip=10.4.10.243,unc=\\PMDS-3HZGD42\htdocs,user=dlgeba,,domain=stackpole,pass=********
mount error(13): Permission denied
Refer to the mount.cifs(8) manual page (e.g. man mount.cifs)
+ date
Fri Oct 30 11:06:39 EDT 2015
ubuntuUser@pmdsdata3:~$ df
Filesystem                    1K-blocks      Used Available Use% Mounted on
/dev/mapper/vamp206b--vg-root   9165896   2804876   5872368  33% /
none                                  4         0         4   0% /sys/fs/cgroup
udev                             368304         4    368300   1% /dev
tmpfs                             75888       644     75244   1% /run
none                               5120         0      5120   0% /run/lock
none                             379440         0    379440   0% /run/shm
none                             102400         4    102396   1% /run/user
/dev/sda1                        240972     38812    189719  17% /boot
//PMDS-3HZGD42/htdocs         112690172 111846588    843584 100% /mnt/3hz/htdocs
ubuntuUser@pmdsdata3:~$ 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2015-11-29[Nov-Sun]17-33PM

windows:

net view

net view redwe

ping redwe


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

//192.168.88.64/home /mnt/REDEK210/home cifs credentials=/home/ubuntuUser/.smbcredentials,iocharset=utf8,sec=ntlm 0 0 
#

sudo mkdir -p /mnt/REDEK210/home
sudo chmod 755 /mnt/REDEK210/home

leafpad ~./smbcredentials
username=ubuntuUser
password=

chmod 600 ~/.smbcredentials
sudo mount -a

_____________

try:

sudo cat <<EOF >> /etc/fstab
# David Gleba 
//192.168.88.64/home /mnt/REDEK210/home cifs credentials=/home/ubuntuUser/.smbcredredek210,iocharset=utf8,sec=ntlm 0 0 
#
EOF
#
sudo mkdir -p /mnt/REDEK210/home
sudo chmod 755 /mnt/REDEK210/home
#
tee ~./smbcredredek210 <<EOF
username=ubuntuUser
password=agoodpassword
EOF
chmod 600 ~/.smbcredentials
sudo mount -a


_____________


https://wiki.ubuntu.com/MountWindowsSharesPermanently


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

END
# end block comment ===============================

}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set -x
smbmn
date
