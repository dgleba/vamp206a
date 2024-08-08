#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd
source shc/21env.sh
set -vx
source shc/root.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#install virtual box guest additions.
#http://virtualboxes.org/doc/installing-guest-additions-on-ubuntu/
#https://www.virtualbox.org/manual/ch04.html#idp46856128490560
#http://www.binarytides.com/vbox-guest-additions-ubuntu-14-04/
#http://sharadchhetri.com/2014/10/07/ubuntu-14-04-install-virtualbox-guest-additions-also-create-videos/



#sudo apt-get install build-essential module-assistant;
#sudo m-a prepare
#sudo rcvboxadd setup
#sudo apt-get -y install virtualbox-guest-additions-iso
#sudo apt-get install dkms gcc 
sudo apt-get -y install dkms
sudo apt-get -y install build-essential module-assistant

# this seemed to need the answer y on cloud9, 2017-09-10.
sudo m-a prepare

cd 
mkdir -p mnt/tmp01
cd /mnt
wget -N http://download.virtualbox.org/virtualbox/5.0.20/VBoxGuestAdditions_5.0.20.iso
sudo mount -o loop VBoxGuestAdditions_5.0.20.iso /mnt/tmp01
cd /mnt/tmp01
sudo ./VBoxLinuxAdditions.run

# check loaded modules
lsmod | grep -io vboxguest
sleep 2


# info from mac osx setup..
#
# http://askubuntu.com/questions/456400/why-cant-i-access-a-shared-folder-from-within-my-virtualbox-machine
# needed?? ... sudo chmod 777 /home/userName/Share
# good: sudo usermod -aG vboxsf $(whoami)
sudo usermod -aG vboxsf $(whoami)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# add shares to rc.local to start them at boot... grr. this is frustrating....
#
cp /etc/rc.local /etc/rc.local.bk$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
mkdir -p ~/backup
cp /etc/rc.local ~/backup/rc.local.bk$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
#didn't seem to work with mount command.
#this works. but then it didn't the next time :(
#http://askubuntu.com/questions/252853/how-to-mount-a-virtualbox-shared-folder-at-startup
# ggl: ubuntu virtualbox shared folder will not mount on boot
# http://askubuntu.com/questions/365346/virtualbox-shared-folder-mount-from-fstab-fails-works-once-bootup-is-complete
# this is not reliable... use upstart mountvshare.conf instead.
#sudo sed -i "/^exit 0/isleep 6\nmount.vboxsf share203 /home/$userv/share203 vboxsf\n#mount.vboxsf html /var/www/html vboxsf\nsleep 4\nmount html\nmount share203\n" /etc/rc.local

mkdir -p /home/$userv/share203
mkdir -p /var/www/html

#add shares to fstab
cp /etc/fstab /etc/fstab.bk$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
mkdir -p ~/backup
cp /etc/fstab ~/backup/fstab.bk$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")

echo "html      /var/www/html  vboxsf   defaults,noauto  0   0" >> /etc/fstab
#this deoesn't expand the $ubuntuUser variable.. echo "share203  /home/$userv/share203  vboxsf   defaults,noauto  0   0" >> /etc/fstab
#add text share203, then 
sudo sh -c 'echo "share203  /home/share203  vboxsf   defaults,noauto  0   0" >> /etc/fstab'
#now replace line with this text with a whole new line. have to excape / in /home/...
# add _netdev to allow time for the system be ready to mount the share 2017-07-13 ...
sudo sed -i "s/.*share203.*/share203  \/home\/$userv\/share203  vboxsf   defaults,noauto,_netdev  0   0/g" /etc/fstab


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#create upstart script for mounting shared folders...
sudo tee /etc/init/mountvshare.conf <<EOF
description "Test mount"
author      "Your Name"

start on filesystem or runlevel [2345]
stop on shutdown

script

    sleep 8
    #mount html
    mount share203

end script

pre-start script
    echo "[`date`] mountvshare start...." >> /var/log/mountvshare.log
end script

pre-stop script
    rm /var/run/mountvshare.pid
    echo "[`date`] .... stop mountvshare" >> /var/log/mountvshare.log
end script
EOF
#
sudo service mountvshare start


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# mount vbox shares...
#
mkdir -p ~/share203
if mount | grep /share203 > /dev/null; then
    echo "its mounted"
else
    echo "not, so mount it"
	sudo mount -t vboxsf  share203 ~/share203
fi
#sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) vampx ~/share203
#
sudo mkdir -p /var/www/html
if mount | grep /var/www/html > /dev/null; then
    echo "already mounted"
else
    echo "now mount it"
	#sudo mount -t vboxsf  html /var/www/html
fi


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
