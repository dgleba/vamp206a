#!/usr/bin/env bash

# setup vhost...

source shc/21env.sh

cd
set -x
date

vhosts2()
{
sudo tee /etc/apache2/sites-available/phundament1.conf <<EOF
############
#
# http://192.168.3.7:914/django161c/admin/
# http://pmdsdata:8985/django161c/admin/
listen 916
<VirtualHost *:916>
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
#
EOF
}

apache3()
{
  sudo a2dissite phundament1.conf
  sudo a2ensite phundament1.conf
  #sudo service apache2 restart
  sudo service apache2 reload
}

#main section.....................................................................

#echo requested commands...
set -x
date

vhosts2
apache1

date
#
