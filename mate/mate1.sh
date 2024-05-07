#!/usr/bin/env bash
set -x
cd

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# edit the variables in 21env.sh to match your system...
#
source shc/21env.sh

set +vx
echo
echo
echo 24start.sh will commence...
echo
read -t  999 -p "Hit ENTER or wait about 900 seconds" ; echo ;
set -vx

#comment this out for full auto run...
#exit 0

#install utils to allow resizing of gui..
sudo apt-get -y install curl libcurl3 libcurl3-dev php5-curl
sudo apt-get -y install virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

cd
source shc/root.sh
cd
source shc/15samsh.sh
cd
source shc/mate/17docs2.sh
cd
source shc/31base.sh
cd
source shc/34samm.sh
cd



cd
sudo shc/100/124nomachine.sh
cd
#sudo shc/100/163mullvad.sh
cd
