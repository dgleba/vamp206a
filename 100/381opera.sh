#!/usr/bin/env bash

cd
set -x
source shc/21env.sh


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function operai() {
#get opera browser 92mb
sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
sudo sh -c 'wget -O - http://deb.opera.com/archive.key | apt-key add -'
sudo apt-get update
sudo apt-get install opera


#others..
#
# Midori browser?  91mb
#sudo apt-add-repository ppa:midori/ppa && sudo apt-get update -qq && sudo apt-get install midori
#
# 235mb
#sudo apt-get install epiphany-browser

# 104 mb
#sudo apt-get install iceweasel


}  

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

operai
#