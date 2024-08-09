#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd
source shc/21env.sh
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
set -vx

#
# Main: put code here...


#manually put a fresh vne.sh in home/$userv/tmp01


# have it copy new data from c:\var\share203
cd
#rm tmp01/htdocs.pmdsdata3.latest.7z

#copy
cp /home/$userv/share203/htdocs.pmdsdata3.latest.7z tmp01
cp /media/sf_share4/htdocs.pmdsdata3.latest.7z tmp01

    # delete this htdocs if you want to get new files...
cd
cd tmp01
   if  [ ! -d html ] ; then
        cd /home/$userv/tmp01
        #sudo rm -rf htdocs
        read -t 10 -p "Hit ENTER or wait about ten seconds" ; echo ;
        cd /home/$userv/tmp01
        7z x /home/$userv/tmp01/htdocs.pmdsdata3.latest.7z

        # this problem is gone now...
        #7-Zip [64] 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18 p7zip Version 9.20 (locale=en_US.UTF-8,Utf16=on,HugeFiles=on,2 CPUs) Processing archive: /home/$userv/tmp01/htdocs.PMDS-DATA.latest.7z
        #Error: Can not open file as archive
        #htdocs.PMDS-DATA.latest.7z
        #

        source ~/shc/21env.sh
        rsync -vrltgoD /home/$userv/tmp01/html/  /var/www/html
        cd
        #source shc/11get.sh
        cd
        source shc/53imp.sh

#        sudo chown -R root /var/www/html
#        sudo chgrp -hR www-data /var/www/html
#        # also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43
#        sudo chmod -R g+rws  /var/www/html
#        sudo chmod -R o-rw /var/www/html
#        # make only folders +x so they can be cd into.
#        sudo find /var/www/html -type d -exec chmod g+x {} +


        echo Data imported !!!!
        exit
    fi



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


cd
echo You must delete /home/$userv/tmp01/html folder to get new data imported.. Data NOT imported.

