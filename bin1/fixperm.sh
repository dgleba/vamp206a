#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

# Purpose: fix permissions to 'albe' in current folder

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd ; date ; set +vx  ; set -vx ; # echo off, then echo on

source safe/21env.sh
set -vx

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#  current folder
#     Can be.. 2018-11-26.. Just share the whole srv folder, and var/www  with www-data group...
fold=.
sudo groupadd www-data ; sudo usermod -a -G www-data  $userv  # add the user to the www-data group
# sudo mkdir -p ${fold}
sudo chown -hR www-data:www-data  ${fold}
sudo find ${fold} -type d -exec chmod g+x {} +  # make only folders +x so they can be cd into.
sudo chmod -R u+rw,g+rws  ${fold}  #also set the group sticky bit, so group is set for new files. chmod g+s . – jris198944 May 13 '14 8:43 
# optional..
sudo chmod -R        o+r  ${fold}  #also set the group sticky bit, so group is set for new files. chmod g+s . – jris198944 May 13 '14 8:43 
groups

#

#optional..

sudo chmod -R o-w  ${fold}  #also set the group sticky bit, so group is set for new files. chmod g+s . – jris198944 May 13 '14 8:43 


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

_____________ 

_____________ 

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set +vx