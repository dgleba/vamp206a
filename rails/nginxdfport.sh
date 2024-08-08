#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  set nginx default port to 82


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#change nginx      default port     to 82 so apache still works on 80..

#sudo leafpad /etc/nginx/sites-enabled/default
# orig settings...
#    listen 80 default_server;
#    listen [::]:80 default_server ipv6only=on;

# backup..
sudo cp  /etc/nginx/sites-enabled/default  /etc/nginx/sites-enabled/default.$(date "+%Y-%m-%d_%s").bk
sudo cp  /etc/nginx/sites-available/default  /etc/nginx/sites-available/default.$(date "+%Y-%m-%d_%s").bk
# remove line containing  '?????'  and replace the line completely with the new text...
nowdg1=`date +'__%Y-%m-%d_%a_%H.%M.%S-%Z'`
sudo sed -i "/.*listen 80 .*/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/nginx/sites-available/default # add marker above the change.
#Use double quotes to make the shell expand variables while keeping whitespace:
sudo sed -i "s/.*listen 80 .*/       listen 82 default_server;/g" /etc/nginx/sites-available/default
sudo sed -i "s/.*80 default_server.*/       listen [::]:82 default_server ipv6only=on;/g" /etc/nginx/sites-available/default

# cat /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-enabled/default
sudo ln -nfs /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# move unneeded config out of the way...
sudo mkdir /etc/nginx/offlinedg
#sudo mv  /etc/nginx/sites-available/default /etc/nginx/offlinedg/default
sudo mv /etc/nginx/sites-enabled/*.bak /etc/nginx/offlinedg
sudo mv /etc/nginx/sites-enabled/*.bk /etc/nginx/offlinedg

sudo service nginx stop
sleep 1
sudo service nginx start
sudo service apache2 restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

