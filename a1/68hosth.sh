#!/usr/bin/env bash

cd
# echo off
set +vx
# echo on
set -vx

#purpose...
#set hostname with   ** hardcoded **  name not env variable.


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo cp /etc/hosts /etc/hosts.bk.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")
sudo cp /etc/hosts /etc/hosts.$(date "+%Y-%m-%d_%s").bk
sudo cp /etc/hostname /etc/hostname.bk.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z")


sudo echo redekv1 | sudo tee /etc/hostname
cat /etc/hostname


sudo tee /etc/hosts <<EOF
#
127.0.0.1	localhost
#127.0.1.1	redekv1.local redekv1.stackpole.ca	redekv1
127.0.1.1	redekv1.local 	redekv1

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
#
EOF


sudo cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.$(date +"%Y-%m-%d_%s").bk

#working on --  hostname=
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo sed -i "/hostname=/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/ssmtp/ssmtp.conf
sudo sed -i "s/.*hostname=.*/hostname=redekv1.local/g" /etc/ssmtp/ssmtp.conf



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
exit 999

# begin block comment =============================
: <<'END'
#begin block comment --  http://stackoverflow.com/questions/947897/block-comments-in-a-shell-script
ls
END
# end block comment ===============================
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#

