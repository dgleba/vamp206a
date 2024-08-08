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
# Used by ifup(8) and ifdown(8). See the interfaces(5) manpage or
# /usr/share/doc/ifupdown/examples for more information.

auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp


#
EOF

#
date
#
