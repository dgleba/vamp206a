#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  set ipaddress

dclark: 10.4.15.105
kashmiri-vm: 10.4.15.106
restore of pmdsdata3 2018-02-07: 10.4.15.250


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


# backup..
sudo cp  /etc/network/interfaces  /etc/network/interfaces$(date "+__%Y.%m.%d_%H.%M.%S").bak.txt

sudo tee /etc/network/interfaces <<EOF
#
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
   address 10.4.15.250
   #stackpole specfic settings
   netmask 255.255.192.0
   #network 10.253.0.0
   gateway 10.4.1.9
   #GOOGLE...
   #dns-nameservers 8.8.8.8
   dns-nameservers 10.4.1.200

#
EOF

#
date
#
