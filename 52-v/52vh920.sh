#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

# Purpose:  vhosts 920
END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

vhosts4()
{
sudo tee /etc/apache2/sites-available/vhost920.conf <<EOF
############
#
# http://10.4.11.19:920
# http://l10.4.10.141:920
# http://192.168.88.58:920
# http://v206b1:920/
# http://localhost:920
listen 920
<VirtualHost *:920>
    #AllowOverride All
    DocumentRoot /var/www/html/python/cif207
    ServerName 127.0.0.1
    #
    WSGIDaemonProcess cif207 user=albe group=www-data processes=1 threads=5 python-path=/var/www/html/python/cif207
    WSGIProcessGroup cif207
    WSGIApplicationGroup %{GLOBAL}
    #
    WSGIScriptAlias / /var/www/html/python/apache/cif207.wsgi
    #
    #allow access to wsgi file...
    <Directory /var/www/html/python/apache>
       Order deny,allow
       Allow from all
     </Directory>
     # deny directory listing of this folder... http://localhost:920
    <Directory /var/www/html/python/cif207>
       AllowOverride All
       Order deny,allow
       Deny from all
     </Directory>
</VirtualHost>
############
#
EOF
}


apache4()
{
  sudo a2dissite vhost920.conf
  sudo a2ensite vhost920.conf
  #sudo service apache2 restart
  sudo service apache2 reload
}

#main section....................................................................

vhosts4
apache4
date
#
