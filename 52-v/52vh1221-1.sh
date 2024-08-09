#!/usr/bin/env bash

# setup drails237a
# works.


source shc/21env.sh
cd; set -x ; date

vhost9()
{
sudo tee /etc/apache2/sites-available/drails237a.conf <<EOF
#
# works on vagrant ubuntu vm 2015-09-28_Mon_23.25-PM 
# http://10.4.15.100:1221/dj224c/admin/
# http://pmdsdata:1221/dj224c/admin/
# http://localhost:1221/dj224c/admin/
listen 1221
<VirtualHost *:1221>
    ServerName 127.0.0.1
    #ServerAlias www.example.com
    #ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/rails/drails237a/public
    RailsEnv development
    ErrorLog ${APACHE_LOG_DIR}/error-drails237a.log
    CustomLog ${APACHE_LOG_DIR}/access-drails237a.log combined
    <Directory "/var/www/html/rails/drails237a/public">
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
#
EOF
}

apache9()
{
  sudo a2dissite drails237a.conf
  sudo a2ensite drails237a.conf
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
