#!/usr/bin/env bash

# setup django and django apps...

source shc/21env.sh
cd; set -x ; date

vhost9()
{
sudo tee /etc/apache2/sites-available/dj224b.conf <<EOF
#
# works on vagrant ubuntu vm 2015-09-28_Mon_23.25-PM 
# http://192.168.3.7:1219/dj224b/admin/
# http://192.168.88.65:1219/dj224b/admin/
# http://pmdsdata:1219/dj224b/admin/
# http://localhost:1219/dj224b/admin/
listen 1219
<VirtualHost *:1219>
    DocumentRoot /var/www/html/django/dj224b
    ServerName 127.0.0.1
    #
    Alias /static/ /var/www/html/django/static/
    #
    WSGIDaemonProcess dj224b processes=1 threads=5 display-name=%{GROUP}
    WSGIProcessGroup dj224b
    #
    WSGIScriptAlias /dj224b /var/www/html/django/apache/dj224b.wsgi
    #
    <Directory /var/www/html/django/apache>
       Order deny,allow
       Allow from all
     </Directory>
</VirtualHost>
#
#---
#
EOF
}

apache9()
{
  sudo a2dissite dj224b.conf
  sudo a2ensite dj224b.conf
  sudo service apache2 restart
  sudo service apache2 reload
}

#main section.....................................................................

#echo requested commands...
set -x ; date

vhost9
apache9

#
date
#
