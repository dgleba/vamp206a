#!/usr/bin/env bash
cd
set -x
source shc/21env.sh











#Multiple users...
#this is ridiculous
# port dedicated to a user. ugh. can it be any more un-sustainable?
#http://ubuntuforums.org/showthread.php?t=1053242&p=7442474#post7442474
#http://askubuntu.com/questions/581979/ubuntu-14-10-multiple-simultaneous-independent-remote-desktop-like-connection











#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function vnc2() {

#install x11vnc
#https://help.ubuntu.com/community/VNC/Servers

# done by tightvnc setup...   x11vnc -storepasswd

sudo apt-get install -y x11vnc

#create upstart script for starting vnc...
sudo tee /etc/init/x11vnc1.conf <<EOF
description "x11vnc start"
author      "David Gleba"

start on runlevel [2345]
stop on runlevel [^2345]

console log

respawn
respawn limit 20 5

exec /usr/bin/x11vnc  -noxdamage -repeat -rfbauth /home/albe/.vnc/passwd -rfbport 5900 -shared

EOF

init-checkconf /etc/init/x11vnc1.conf

sudo chown -R albe .vnc

sudo service x11vnc1 start
ps -ef | grep vnc


}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
exit 999


#unfinished....  vnc password.......
#
#use expect to silently answer questions in vnc password script...
#!/bin/sh
#http://askubuntu.com/questions/328240/assign-vnc-password-using-script
prog=x11vnc -storepasswd
#mypass=$pw1  #too short
mypass=$pw4
expect <<EOF
spawn "$prog"
expect "Enter VNC password:"
send "$mypass\r"
expect "Verify password:"
send "$mypass\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\r"
expect eof
exit
EOF

]-


 --- x11vnc loop: waiting for: 4686

07/08/016 13:43:56 passing arg to libvncserver: -rfbauth
07/08/2016 13:43:56 passing arg to libvncserver: /home/albe/.vnc/passwd
07/08/2016 13:43:56 passing arg to libvncserver: -rfbport
07/08/2016 13:43:56 passing arg to libvncserver: 5900
07/08/2016 13:43:56 x11vnc version: 0.9.13 lastmod: 2011-08-10  pid: 4686
xauth:  unable to generate an authority file name
07/08/2016 13:43:56 -auth guess: failed for display='unset'
07/08/2016 13:43:56 -auth guess: since we are root, retrying with FD_XDM=1
07/08/2016 13:43:56 -auth guess: failed for display='unset'

 --- x11vnc loop: sleeping 2000 ms ---
 
exec /usr/bin/x11vnc -auth guess -forever -loop -noxdamage -repeat -rfbauth /home/albe/.vnc/passwd -rfbport 5900 -shared


}



#main..
vnc2
#

