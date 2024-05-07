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

cd
source safe/21env.sh
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

groups
groups $userv
id $userv



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#  override - with new concept...  
#      Just share the whole srv folder, and var/www  with www-data group...   2018-07-06


# New 2018-07-06 Just share the whole srv folder, and var/www  with www-data group...
#
fold=/srv
sudo groupadd www-data ; sudo usermod -a -G www-data  $userv  # add the user to the www-data group
sudo mkdir -p ${fold}
sudo chgrp -hR www-data ${fold}
sudo chown -R www-data  ${fold}
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  ${fold}
sudo chmod -R o-rw ${fold}
# make only folders +x so they can be cd into.
sudo find ${fold} -type d -exec chmod g+x {} +
sudo usermod -a -G www-data  $userv


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# make srv/web folder and change permissions...
# my standard practice for web apps...
#
sudo mkdir -p /srv/web
sudo chgrp -hR www-data /srv/web # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /srv/web 
sudo chmod -R g+rw  /srv/web # writable for group
sudo chmod -R o-rw /srv/web # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /srv/web -type d -exec chmod g+x {} +
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  /srv/web 

# to be able to backup web config...
sudo chmod -R o+r /etc/nginx # viewable for ..
sudo chmod -R o+r /etc/apache2 # viewable for ..
cd
#

# could be.. 2018-11-26.. see below.. # any-folder
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
# sudo mkdir -p /srv/web
# sudo chown -hR root:www-data /srv/web 
# sudo chmod -R g+rws,o-rw  /srv/web # writable for group # change group to www-data ( apache group. apache already was installed.)
# sudo find /srv/web -type d -exec chmod g+x {} +
# was...
#sudo chgrp -hR www-data /srv/web # change group to www-data ( apache group. apache already was installed.)
#sudo chmod -R o-rw /srv/web # not viewable for others..
# make only folders +x so they can be cd into.
#sudo chmod -R g+rws  /srv/web 



# to be able to backup web config...
sudo chmod -R o+r /etc/nginx # viewable for ..
sudo chmod -R o+r /etc/apache2 # viewable for ..
cd
#


# any-folder
# Can be.. 2018-11-26.. Just share the whole srv folder, and var/www  with www-data group...
fold=/srv/dkr/data
sudo mkdir -p ${fold}
sudo chown -hR www-data:www-data  ${fold}
sudo chmod -R g+rws,o-rw  ${fold}  #also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo find ${fold} -type d -exec chmod g+x {} +  # make only folders +x so they can be cd into.
sudo usermod -a -G www-data  $userv  # add the user to the www-data group
#


# temporary measure 2018-07-06 Just share the whole srv without recursing - faster if srv has lots of stuff in it.
#
fold=/srv
sudo mkdir -p ${fold}
sudo chgrp -h www-data ${fold}
sudo chown  www-data  ${fold}
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod  g+rws  ${fold}
sudo chmod  o-rw ${fold}
# make only folders +x so they can be cd into.
#  offline -- sudo find ${fold} -type d -exec chmod g+x {} +
# sudo usermod -a -G www-data  $userv


# temporary measure 2018-07-06 Just share the whole var/www without recursing - faster if srv has lots of stuff in it.
#
fold=/var/www
sudo mkdir -p ${fold}
sudo chgrp -h www-data ${fold}
sudo chown  www-data  ${fold}
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod  g+rws  ${fold}
sudo chmod  o-rw ${fold}
# make only folders +x so they can be cd into.
#  offline -- sudo find ${fold} -type d -exec chmod g+x {} +
# sudo usermod -a -G www-data  $userv



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# make srv/web folder and change permissions...
# my standard practice for web apps...
#
sudo mkdir -p /srv/file
sudo chgrp -hR www-data /srv/file # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /srv/file 
sudo chmod -R g+rw  /srv/file # writable for group
sudo chmod -R o-rw /srv/file # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /srv/file -type d -exec chmod g+x {} +
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo chmod -R g+rws  /srv/file 
#

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

