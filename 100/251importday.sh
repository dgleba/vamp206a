#!/usr/bin/env bash

echo starting 251importday.sh  - this imports fresh data daily...

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
dgmethod="m1"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

date
set -x
cd
source shc/21env.sh

# make directories. # html
sudo chmod -R 700 tmp01
sudo mkdir -p /var/www/html

#
# make tempfiles folder writable. This is used with cilist, tnlist and others to write excel files and mail them..
#
sudo mkdir -p /tmp01/tempfiles
sudo chmod -R 700 /tmp01/tempfiles
 

if [ $dgmethod = "m1" ] ; then

 
        if ping -c 1 192.168.88.64 &> /dev/null
        then
            cp /mnt/REDEK210/home/albe/Dropbox/csd/copyof/CI/backups/htdocs/htdocs.PMDS-DATA.latest.7z tmp01
        else
              read -t 33 -p "Oops, cannot ping redek210.  Press Enter." ; echo ;
                try dropbox...
                cd
                wget -v https://www.dropbox.com/s/editme-editme-editme/htdocs.PMDS-DATA.latest.7z-editme-?dl=1 -O  tmp01/htdocs.PMDS-DATA.latest.7z

            #exit 8
        fi
        
        cd /home/$userv/tmp01
        sudo rm -rf htdocs
        read -t 10 -p "Hit ENTER or wait about ten seconds" ; echo ;
        cd /home/$userv/tmp01
        7z x /home/$userv/tmp01/htdocs.PMDS-DATA.latest.7z
        source ~/shc/21env.sh
        sudo rsync -vrltgoD /home/$userv/tmp01/htdocs/  /var/www/html
  
fi

cd

source shc/53imp.sh
date


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



function offline()
{
exit 999

cd 
  curl -O -u dg ftp://108.168.7.195:46237//home/dg/www/Dropbox/csd/serve/vboxyard/htdocs/htdocs.PMDS-DATA.latest.7z

}
