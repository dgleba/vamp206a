#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#
# Main: put code here...

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# How to restart the network


# seems to work:

sudo ifdown enp0s3 && sudo ifup enp0s3


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# https://askubuntu.com/questions/396837/detecting-the-name-of-a-network-device-in-bash
# show 
# ubuntu determine network interface name

lspci
ip -o link show | awk '{print $2,$9}'
ip -o link 
ifconfig -a
ip a




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

return 9


Notes:

the rest will not excecute......



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ubuntu server 16 auto set network interface



https://help.ubuntu.com/community/NetworkConfigurationCommandLine/Automatic


ip a


sudo ip link set dev enp0s3 down
sudo dhclient enp0s3




sudo vi /etc/network/interfaces
## To configure a dynamic IP address
auto eth0
iface eth0 inet dhcp




For these settings to take effect you need to restart your networking services.

  sudo /etc/init.d/networking restart

  # sudo  systemctl restart networking.service

# works..
  sudo  systemctl restart networking
  
  

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
















#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


no:
sudo service networking restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2016-01-21[Jan-Thu]19-44PM

ip release and renew

sudo dhclient -r wlan0
sudo dhclient wlan0

sudo dhclient -r enp0s3
sleep 2
ifconfig
sudo dhclient enp0s3
ifconfig enp0s3




hmm..
no, this is wrong!!!!!!!!!!
sudo ifconfig down
sudo ifconfig up


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#
date
#
