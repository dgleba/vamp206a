#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

# Purpose: create shared folder for a group to work in.

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#
source shc/21env.sh
set -vx

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# make a shared folder and allow www-data group to write to it...
# sudo groupadd www  ..#.. just use www-data group
sudo mkdir -p /srv/share
sudo chgrp -hR www-data /srv/share
sudo chown -R www-data  /srv/share
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  /srv/share 
sudo chmod -R o-rw /srv/share
# make only folders +x so they can be cd into.
sudo find /srv/share -type d -exec chmod g+x {} +
sudo usermod -a -G www-data  $userv


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

groups
groups $userv
id $userv

#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# make xx folder and change permissions...
#
sudo mkdir -p /media/sf_share
sudo chgrp -hR www-data /media/sf_share # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /media/sf_share 
sudo chmod -R g+rw  /media/sf_share # writable for group
sudo chmod -R o-rw /media/sf_share # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /media/sf_share -type d -exec chmod g+x {} +
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  /media/sf_share 
#

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# set access to html files here..  [chmod chown chgrp]

# also see 62srvweb.sh for permissions.

# sudo groupadd www  # just use www-data group
# sudo chgrp -hR www /var/www/html
#
# chown and chgrp the html files appropriately.. chgrp -hR www-data /var/www/html

sudo mkdir -p /var/www/html
sudo chown -R root /var/www/html
sudo chgrp -hR www-data /var/www/html
# also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  /var/www/html
sudo chmod -R o-w /var/www/html
sudo chmod -R o+r /var/www/html

# remove read permissions from a list of files - files with secrets.
 sudo chmod -R o-r  `cat shc/62grpshareperm.txt`

# make only folders +x so they can be cd into.
sudo find /var/www/html -type d -exec chmod g+x {} +
# make  *.sh files executable
sudo find *.sh /var/www/html  -exec chmod g+x {} +

sudo usermod -a -G adm,dialout,plugdev,sambashare,sudo  $userv
sudo usermod -a -G www-data  $userv


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# set access to home/file files here..  [chmod chown chgrp]

# sudo groupadd www  # just use www-data group
# sudo chgrp -hR www /var/www/html
#
# chown and chgrp the html files appropriately.. chgrp -hR www-data /var/www/html
sudo mkdir -p  /home/file
sudo chown -R root /home/file
sudo chgrp -hR www-data /home/file
# also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  /home/file
sudo chmod -R o-rw /home/file
# make only folders +x so they can be cd into.
sudo find /home/file -type d -exec chmod g+x {} +
# make  *.sh files executable
sudo find *.sh /home/file  -exec chmod g+x {} +


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# set access to /var/www/html/test2/Codiad files here..  [chmod chown chgrp]

folder1="/var/www/html/test2/Codiad"
#
# chown and chgrp the html files appropriately.. chgrp -hR www-data /var/www/html
sudo chown -R root $folder1
sudo chgrp -hR www-data $folder1
# also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  $folder1
sudo chmod -R o-rw $folder1
# make only folders +x so they can be cd into.
sudo find $folder1 -type d -exec chmod g+x {} +
# make  *.sh files executable
sudo find *.sh $folder1 -exec chmod g+x {} +


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

_____________ 


files to revoke read permissions from..

https://superuser.com/questions/543306/how-can-i-chmod-chown-a-specific-list-of-files

see 62grpshareperm.txt
*.ini
*.dbc
*.py
*.rb
*.yml
*.env
*.conf
*.sql
*.csv
*.txt

_____________ 



END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

