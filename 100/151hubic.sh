#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#hubic..

#https://forums.hubic.com/showthread.php?272-hubiC-for-Linux-beta-is-out-!

mkdir -p 09
cd 09
wget http://mir7.ovh.net/ovh-applications/hubic/hubiC-Linux/2.1.0/hubiC-Linux-2.1.0.53-linux.deb

sudo apt-get update
sudo apt-get -y install mono-runtime
sudo apt-get -y install libmono-system-data-datasetextensions4.0-cil
sudo apt-get -f install 

sudo dpkg -i hubiC-Linux-2.1.0.53-linux.deb
sudo apt-get -f install 

mkdir -p /home/albe/hubic

hubic login dgleba@gmail.com /home/albe/hubic

hubic status


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline()
{
exit 999
# begin block comment =============================
: <<'END'

comment content
ls

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#

