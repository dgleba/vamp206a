#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:   create unique hostname

https://acritiqueofplanetearth.wordpress.com/2013/11/14/6/


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#
cd
source shc/root.sh


# Main: put code here...

# include the date in the hostname to get a unique hostname
export hostv="v206x"
export hnow=$(date +"%Y%m%d%H%M%S")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sudo mkdir -p /var/log/v206

sudo cp /etc/hosts /var/log/v206/hosts.bk.$(date +"__%Y-%m-%d_%a_%H.%M.%S-%Z")
sudo cp /etc/hostname /var/log/v206/hostname.bk.$(date +"__%Y-%m-%d_%a_%H.%M.%S-%Z")
sudo cp /etc/ssmtp/ssmtp.conf /var/log/v206/ssmtp.conf.bk.$(date +"%__%Y-%m-%d_%a_%H.%M.%S-%Z")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# include the date in the hostname to get a unique hostname

sudo echo $hostv$hnow.local | sudo tee /etc/hostname
cat /etc/hostname

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo tee /etc/hosts <<EOF
#
127.0.0.1	localhost
127.0.0.1	$hostv$hnow.local 	$hostv$hnow

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
#
EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#working on --  hostname=
#nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
#sudo sed -i "/hostname=/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/ssmtp/ssmtp.conf
sudo sed -i "s/.*hostname=.*/hostname=$hostv$hnow.local/g" /etc/ssmtp/ssmtp.conf

set +vx ; echo " "; echo "  Hostname changed. Please reboot...  "
