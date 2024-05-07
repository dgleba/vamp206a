#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

Purpose.. Set permistions of current folder...



old..
Purpose: create a folder to work in.
#sudo mkdir -p /files
#sudo chown albe /files

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 date ; set +vx  ; set -vx ; # echo off, then echo on
#


# set access to . files here..  [chmod chown chgrp]

# sudo groupadd www  # just use www-data group
# sudo chgrp -hR www /var/www/html
#
# chown and chgrp the html files appropriately.. chgrp -hR www-data /var/www/html
sudo chown -R root .
sudo chgrp -hR www-data .
# also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  .
sudo chmod -R o-rw .
# make only folders +x so they can be cd into.
sudo find .  -type d -exec chmod g+x {} +
# make  *.sh files executable
sudo find *.sh .  -exec chmod g+x {} +
# make files  with no extension executable
sudo find . -type f ! -name "*.*"  -exec chmod g+x {} +

#
date
#
