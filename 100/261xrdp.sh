#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  install xrdp - remote desktop


lxde....
http://c-nergy.be/blog/?p=5357




older...

http://askubuntu.com/questions/449785/ubuntu-14-04-xrdp-grey

sudo apt-get install xrdp
sudo apt-add-repository ppa:ubuntu-mate-dev/ppa -y
sudo apt-add-repository ppa:ubuntu-mate-dev/trusty-mate -y
sudo apt-get update 
#sudo apt-get upgrade
#sudo apt-get install ubuntu-mate-core ubuntu-mate-desktop

echo xfce4-session >~/.xsession
or
echo mate-session >~/.xsession
sudo service xrdp restart

http://c-nergy.be/blog/?p=5305


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...

sudo apt-get install xrdp

echo lxsession -s LXDE -e LXDE > ~/.xsession

# connect to same session..
#replace only the first occurrence  --  sed -i -e '0,/foo/s/foo/bar/' filename -  http://stackoverflow.com/questions/148451/how-to-use-sed-to-replace-only-the-first-occurrence-in-a-file
sudo sed -i -e '0,/port=-1/s/port=-1/port=ask-1/'  /etc/xrdp/xrdp.ini


sudo service xrdp restart

# now  rdp in by ip address...
# works.

# no clipboard support between linux and windows.. too bad.

#
date
#
