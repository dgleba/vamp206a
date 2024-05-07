#!/usr/bin/env bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#!/usr/bin/env bash

set +vx
echo
echo this is not finished to run as a script. Just copy paste from this file..
echo
echo exiting...
echo
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
exit 99



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



saynow()
{
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline21() {

echo tmp1
exit 999

: <<'BLOCKCOMMENT'

  Purpose:   
        setup kashmiri1 server for PLC data historian with ingition OPCUA and influxdb etc.
            2017-02-16_Thu_13.54-PM


            
            see also
            C:\n\Dropbox\csd\2017a\kashmiri_machineprocessdatacollection\setup-kashmiri\*
            
            
BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow
#


# xubu1604 vbox on pmds-8lzwln1 pc [from osboxes.org]

# in osboxes.org user...

history
 sudo apt-get update
 sudo apt-get install git
 git clone https://github.com/dgleba/vamp206a.git shc
 chmod -R 775 shc/
 shc/bin1/nuser.sh albe
 ifconfig
 sudo usermod -a -G sudo albe
 passwd

# no longer use osboxes.org user.


#  in user albe..

sudo timedatecdl set-timezone EST
sudo apt-get install xrdp
mkdir -p bin
cd /home/osboxes/shc/
git pull
sudo chmod -R 770 .
sudo /home/osboxes/shc/100/262xrdp-xfce.sh
ps axf
netstat -tulpn
cd
git clone https://github.com/dgleba/vamp206a.git shc
chmod -R 770 shc
sudo shc/100/102staticip-16.04.sh
ifconfig
ping -c 4 google.com
sudo apt-get install openssh-server
sudo groupadd www-data
sudo usermod -a -G www-data,sambashare albe

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# make srv/web folder and change permissions...
# my standard practice for web apps...
#
sudo mkdir -p /srv/web
sudo chgrp -hR www-data /srv/web # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /srv/web
sudo chmod -R g+rw /srv/web # writable for group
sudo chmod -R o-rw /srv/web # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /srv/web -type d -exec chmod g+x {} +
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43
sudo chmod -R g+rws /srv/web

# to be able to backup web config...
sudo chmod -R o+r /etc/nginx # viewable for ..
sudo chmod -R o+r /etc/apache2 # viewable for ..
cd
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# make srv/web folder and change permissions...
# my standard practice for web apps...
#
sudo mkdir -p /srv/file
sudo chgrp -hR www-data /srv/file # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /srv/file
sudo chmod -R g+rw /srv/file # writable for group
sudo chmod -R o-rw /srv/file # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /srv/file -type d -exec chmod g+x {} +
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43
sudo chmod -R g+rws /srv/file
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

hostname
sudo shc/68hostp.sh kashmiri1
sudo ip addr flush enp0s3 && sudo systemctl restart networking
sudo reboot




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




