#!/usr/bin/env bash

# setup django and django apps...
# copy dj162 to dj224c and edit it. replace dj162 with dj224c in the django project code.
# works.


source shc/21env.sh
cd; set -x ; date

vhost9()
{
sudo tee /etc/apache2/sites-available/dj224c.conf <<EOF
#
# works on vagrant ubuntu vm 2015-09-28_Mon_23.25-PM 
# http://192.168.3.7:1220/dj224c/admin/
# http://192.168.88.65:1220/dj224c/admin/
# http://pmdsdata:1220/dj224c/admin/
# http://localhost:1220/dj224c/admin/
listen 1220
<VirtualHost *:1220>
    DocumentRoot /var/www/html/django/dj224c
    ServerName 127.0.0.1
    #
    Alias /static/ /var/www/html/django/static/
    #
    WSGIDaemonProcess dj224c processes=1 threads=5 display-name=%{GROUP}
    WSGIProcessGroup dj224c
    #
    WSGIScriptAlias /dj224c /var/www/html/django/apache/dj224c.wsgi
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
  sudo a2dissite dj224c.conf
  sudo a2ensite dj224c.conf
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
