#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  set ipaddress

dclark: 10.4.15.105
kashmiri-vm: 10.4.15.106


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
auto enp0s3
iface enp0s3 inet static
   address 10.4.15.106
   #stackpole specfic settings
   netmask 255.255.192.0
   #network 10.253.0.0
   gateway 10.4.1.9
   #GOOGLE...
   #dns-nameservers 8.8.8.8
   dns-nameservers 10.4.1.200

#
EOF

sudo ip addr flush enp0s3 && sudo systemctl restart networking
ip add
ping -c 3 google.com


#
date
#
