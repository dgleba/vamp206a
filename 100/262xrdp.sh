#!/usr/bin/env bash

saynowfunc()
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


https://www.google.com/url?q=http://www.technig.com/remote-access-windows-10-via-ubuntu-vise-versa/&usd=2&usg=AFQjCNHS2FBD5Krg86fnZVepF0oRNqBWnQ

https://www.google.com/url?q=http://raspberrypi.stackexchange.com/questions/56413/error-problem-connecting-to-raspberry-pi-3-with-xrdp&usd=2&usg=AFQjCNFsQZEpmC-A-ztez2c5wHMgunc7BA

https://www.google.com/url?q=http://c-nergy.be/blog/%3Fp%3D5305&usd=2&usg=AFQjCNF7pYQXNBx4Bwl0Wp7EGW-uBtbujQ

https://www.google.com/url?q=http://askubuntu.com/questions/797973/error-problem-connecting-windows-10-rdp-into-xrdp&usd=2&usg=AFQjCNFCoZ7_raa_qK5a5RXG4X2zPNupxg


_____________


for mint 18.1 xfce I did:
    Now the second file we need to edit is the startup file for xRDP, so it will start xfce4 service on startup.
    “sudo nano /etc/xrdp/startwm.sh”
    startxfce4


_____________


vamp206a csd dg 2017-02-10
works.
use 1680 x 1050 it fits nicely on second monitor. I had to use dgleba cause albe would not connect.
or
works..
mstsc.exe /v:10.4.15.100  /w:1680 /h:960 

_____________


but now getting.
xrdp_mm_process_login_response:login failed

ref.  http://linuxtoolkit.blogspot.ca/2013/03/xrdpmmprocessloginresponse-login-failed.html
    http://linuxtoolkit.blogspot.ca/2013/09/x-server-no-display-in-range-is.html



BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynowfunc
#


sudo apt-get update
sudo apt-get -y install  tightvncserver
sudo apt-get -y install  xrdp

echo lxsession -s LXDE -e LXDE > ~/.xsession

# connect to same session..
#http://askubuntu.com/questions/133343/how-do-i-set-up-xrdp-session-that-reuses-an-existing-session
# reconnect to 5910 or change it to 5911
#replace only the first occurrence  --  sed -i -e '0,/foo/s/foo/bar/' filename -  http://stackoverflow.com/questions/148451/how-to-use-sed-to-replace-only-the-first-occurrence-in-a-file
sudo sed -i -e '0,/port=-1/s/port=-1/port=ask-5910/'  /etc/xrdp/xrdp.ini

sudo apt-get -y install libglib2.0-bin
gsettings set org.gnome.Vino require-encryption false

# May not need this...
    sudo apt-get -y remove  xrdp vnc4server tightvncserver 
    sudo apt-get -y install   tightvncserver 
    sudo apt-get -y install   xrdp


sudo service xrdp restart


