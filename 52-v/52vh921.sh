#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

# Purpose:  vhosts 921

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

vhosts4()
{
sudo tee /etc/apache2/sites-available/vhost921.conf <<EOF
############
#
# http://10.4.11.19:921/sqla
# http://l10.4.10.141:921/sqla
# http://192.168.88.65:921
# http://localhost:921/
listen 921
<VirtualHost *:921>
    #AllowOverride All
    DocumentRoot /var/www/html/python/flask213f
    ServerName 127.0.0.1
    #
    WSGIDaemonProcess flask213f user=albe group=www-data processes=1 threads=5 python-path=/var/www/html/python/flask213f
    #
    #copy app1 to app3, edit edit route to include /flask213f
    #     return '<a href="/flask213f/admin/">Click me to get to Admin!</a>'
    #
    WSGIProcessGroup flask213f
    WSGIApplicationGroup %{GLOBAL}
    #
    WSGIScriptAlias / /var/www/html/python/flask213f/apache/flask213f.wsgi
    #
    #allow access to wsgi file...
    <Directory /var/www/html/python/apache>
       Order deny,allow
       Allow from all
     </Directory>
     # deny directory listing of this folder... http://localhost:921??
    <Directory /var/www/html/python/flask213f/apache>
       Order deny,allow
       allow from all
       AllowOverride All
     </Directory>
 </VirtualHost>
############
#
EOF
}


apache4()
{
  sudo a2dissite vhost921.conf
  sudo a2ensite vhost921.conf
  #sudo service apache2 restart
  sudo service apache2 reload
}

#main section....................................................................

vhosts4
apache4
date
#
