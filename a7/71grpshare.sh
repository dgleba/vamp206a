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
set -vx

. ~/12settings.sh


# 2017-09-20
#allow export to this folder due to..
#   mysqldump: Got error: 1290: The MySQL server is running with the --secure-file-priv option so it cannot execute this statement when executing 'SELECT INTO OUTFILE'
#    mysqldump: Got error: 1: Can't create/write to file '/var/lib/mysql-files/leanmfg/dataface__failed_logins.txt' (Errcode: 13) when executing 'SELECT INTO OUTFILE'

# https://serverfault.com/questions/349145/can-i-override-my-umask-using-acls-to-make-all-files-created-in-a-given-director
# https://unix.stackexchange.com/questions/1314/how-to-set-default-file-permissions-for-all-folders-files-in-a-directory

# Title:  . find line with pattern, then edit another part of the line.
#  /ipsum/ selects lines containing "ipsum" and only on these lines the command(s) that follow are executed. You can use braces to run more commands
#   /ipsum/{s/#//g;s/@/-at-/g;}
file22=/etc/fstab
sudo  cp $file22 $file22.bk.$(date +"__%Y-%m-%d_%a_%k.%M.%S-%Z").txt
sudo  cp $file22 $file22.bk.txt
sudo  sed -i '/\ \/\ /{s/errors=remount-ro/errors=remount-ro,acl/g;}' $file22

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# New 2018-07-06 Just share the whole srv folder, and var/www  with www-data group...
#
fold=/srv
id $userv
sudo  /usr/sbin/groupadd www-data ;  
sudo  /usr/sbin/usermod -a -G www-data  $userv  # add the user to the www-data group
sudo  /usr/sbin/usermod -a -G www-data  $USER
sudo  mkdir -p ${fold}
sudo  chgrp -hR www-data ${fold}
sudo  chown -R www-data  ${fold}
#also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
sudo  chmod  g+rws  ${fold}
sudo  chmod -R g+rws  ${fold}
sudo  chmod  o-rw ${fold}
sudo  chmod -R o-rw ${fold}
# make only folders +x so they can be cd into.
 find ${fold} -type d -exec sudo chmod g+x {} +
sudo  /usr/sbin/usermod -a -G www-data  $userv
sudo  setfacl -R -m group:www-data:rwx  ${fold}



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# New 2018-07-06 Just share the whole srv folder, and var/www  with www-data group...
#
# fold=/srv
 # mkdir -p ${fold}
 # chgrp -hR www-data ${fold}
 # chown -R www-data  ${fold}
# #also set the group sticky bit, so that the group is set for new files created. chmod g+s /home/shared – jris198944 May 13 '14 at 8:43 
 # chmod -R g+rws  ${fold}
 # chmod -R o-rw ${fold}
# # make only folders +x so they can be cd into.
 # find ${fold} -type d -exec chmod g+x {} +
 # /usr/sbin/usermod -a -G www-data  $userv
 # setfacl -R -m group:www-data:rwx  ${fold}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



groups
groups $userv
id $userv


 /usr/sbin/usermod -a -G www-data  $userv


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

set +vx