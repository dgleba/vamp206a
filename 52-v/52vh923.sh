#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

# Purpose:  vhosts 923
END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

vhosts4()
{
sudo tee /etc/apache2/sites-available/vhost923.conf <<EOF
############
#
# http://10.4.11.19:923
# http://192.168.88.58:923
# http://v206b1:923/
# http://localhost:923
listen 923
<VirtualHost *:923>
    #AllowOverride All
    DocumentRoot /var/www/html/python/cif207d
    ServerName 127.0.0.1
    #
    WSGIDaemonProcess cif207d user=albe group=www-data processes=1 threads=5 python-path=/var/www/html/python/cif207d
    WSGIProcessGroup cif207d
    WSGIApplicationGroup %{GLOBAL}
    #
    WSGIScriptAlias / /var/www/html/python/apache/cif207d.wsgi
    #
    #allow access to wsgi file...
    <Directory /var/www/html/python/apache>
       Order deny,allow
       Allow from all
     </Directory>
     # deny directory listing of this folder... http://localhost:923
    <Directory /var/www/html/python/cif207d>
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
  sudo a2dissite vhost923.conf
  sudo a2ensite vhost923.conf
  #sudo service apache2 restart
  sudo service apache2 reload
}

#main section....................................................................

vhosts4
apache4
date
#
