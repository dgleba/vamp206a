#!/usr/bin/env bash
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

# setup django and django apps...

source safe/21env.sh

cd
set -vx
date

vhost8985()
{
sudo tee /etc/apache2/sites-available/djangolin1.conf <<EOF
#
# works on vagrant ubuntu vm 2015-09-28_Mon_23.25-PM 
# http://192.168.3.7:8985/django161c/admin/
# http://pmdsdata:8985/django161c/admin/
# http://localhost:8985/django161c/admin/
listen 8985
<VirtualHost *:8985>
    DocumentRoot /var/www/html/django/django161c
    ServerName 127.0.0.1
    #ServerAdmin xx
    #ServerAlias xx
    #ErrorLog /path/to/first/project/logs/error.log
    #CustomLog /path/to/first/project/logs/access.log combined
    #
    Alias /static/ /var/www/html/django/django161c/static/
    #
    WSGIDaemonProcess django161c processes=1 threads=5 display-name=%{GROUP}
    WSGIProcessGroup django161c
    #
    WSGIScriptAlias /django161c /var/www/html/django/apache/django161c.wsgi
    #
    <Directory /var/www/html/django/apache>
       Order deny,allow
       Allow from all
     </Directory>
</VirtualHost>
#
#---
#
############
# works on vagrant ubuntu vm 2015-09-28_Mon_23.25-PM 
# http://192.168.3.5:8986/trakberry/admin/
listen 8986
<VirtualHost *:8986>
    DocumentRoot /var/www/html/django/trakberry
    ServerName 127.0.0.1
    #ServerAdmin xx
    #ServerAlias xx
    #ErrorLog /path/to/first/project/logs/error.log
    #CustomLog /path/to/first/project/logs/access.log combined
    #
    Alias /static/ /var/www/html/django/trakberry/static/
    #
    WSGIDaemonProcess trakberry processes=1 threads=5 display-name=%{GROUP}
    WSGIProcessGroup trakberry
    #
    WSGIScriptAlias /trakberry /var/www/html/django/apache/trakberry-lin.wsgi
    #
    <Directory /var/www/html/django/apache>
       Order deny,allow
       Allow from all
     </Directory>
</VirtualHost>
#
#---
#
############
# http://pmds-data.stackpole.ca:8987/mysite/admin/
# http://192.168.88.33:8987/mysite/admin/
listen 8987
<VirtualHost *:8987>
    DocumentRoot /var/www/html/django/mysite
    ServerName 127.0.0.1
    Alias /static/ /var/www/html/django/mysite/static/
    WSGIDaemonProcess mysite processes=1 threads=5 display-name=%{GROUP}
    WSGIProcessGroup mysite
    WSGIScriptAlias /mysite /var/www/html/django/apache/mysite-lin.wsgi 
    <Directory /var/www/html/django/apache>
        Order deny,allow
        Allow from all
    </Directory>
</VirtualHost>
#
############
#
<VirtualHost *:80>
    ServerName dj162.$HOSTNAME
    redirect / $HOSTNAME:8988/dj162
</VirtualHost>
#
#  http://pmdsdata.stackpole.ca:8988/dj162/admin/
#  http://vamp206b:8988/dj162/admin/
#  http://localhost:8988/dj162/admin/
listen 8988
<VirtualHost *:8988>
    DocumentRoot /var/www/html/django/dj162
    ServerName 127.0.0.1
    Alias /static/ /var/www/html/django/dj162/static/
    WSGIDaemonProcess dj162 processes=1 threads=5 display-name=%{GROUP}
    WSGIProcessGroup dj162
    WSGIScriptAlias /dj162 /var/www/html/django/apache/dj162.wsgi 
    <Directory /var/www/html/django/apache>
        Order deny,allow
        Allow from all
    </Directory>
</VirtualHost>
#
#
############
#  http://pmdsdata.stackpole.ca:8990/ci-site/admin/
#  http://vamp206b:8990/ci-site/admin/
#  http://localhost:8990/ci-site/admin/
listen 8990
<VirtualHost *:8990>
    DocumentRoot /var/www/html/django/ci-site
    ServerName 127.0.0.1
    # removed ci-site from alias so that static will be common to all sites in /var/www/html/django folder..
    Alias /static/ /var/www/html/django/static/
    WSGIDaemonProcess ci-site processes=1 threads=5 display-name=%{GROUP}
    WSGIProcessGroup ci-site
    WSGIScriptAlias /ci-site /var/www/html/django/apache/ci-site.wsgi 
    <Directory /var/www/html/django/apache>
        Order deny,allow
        Allow from all
    </Directory>
</VirtualHost>
#
############
############
listen 914
<VirtualHost *:914>
    ServerName 127.0.0.1
    ServerAlias ciyii2
    DocumentRoot /var/www/html/ciyii2/frontend/web/

    <Directory "/var/www/html/ciyii2/frontend/web/">
        # use mod_rewrite for pretty URL support
        RewriteEngine on
        # If a directory or a file exists, use the request directly
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        # Otherwise forward the request to index.php
        RewriteRule . index.php

        # ...other settings...
    </Directory>
</VirtualHost>
############
############
listen 915
<VirtualHost *:915>
    ServerName 127.0.0.1
    ServerAlias ciyii3
    DocumentRoot /var/www/html/ciyii3/backend/web/

    <Directory "/var/www/html/ciyii3/backend/web/">
        # use mod_rewrite for pretty URL support
        RewriteEngine on
        # If a directory or a file exists, use the request directly
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        # Otherwise forward the request to index.php
        RewriteRule . index.php

        # ...other settings...
    </Directory>
</VirtualHost>
############
#
EOF
}



apache1()
{
  sudo a2dissite djangolin1.conf
  sudo a2ensite djangolin1.conf
  #sudo service apache2 restart
  sudo service apache2 reload
}


#main section.....................................................................

#echo requested commands...
set -x
date


vhost8985
apache1
updatedb

date

#
