#!/usr/bin/env bash

# vagrant install..

#_____________

#contents:

# 2015-12-01 worked on ubuntu 14.04 vamp206a

#_____________

cd
# echo off
set +vx
# echo on
set -vx
source shc/21env.sh


#----------------------2015-12-01[Dec-Tue]06-35AM
# Title:  . install virtual box on vamp206a worked.

#http://ubuntuhandbook.org/index.php/2015/07/install-virtualbox-5-0-ubuntu-15-04-14-04-12-04/

sudo apt-get update

sudo apt-get purge virtualbox virtualbox-4* virtualbox-5*


#worked:
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
#got error:  E: Unmet dependencies. Try 'apt-get -f install' with no packages (or specify a solution).
#2015-12-07 - version 5 is not supported...
sudo apt-get -y install virtualbox-4.3

#but this fixed it...
#sudo apt-get -f install

#virtualbox
#works..

sudo apt-get -y install vagrant

sudo apt-get -y install dkms



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
exit 999

}
#