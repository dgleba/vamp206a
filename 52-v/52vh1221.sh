#!/usr/bin/env bash

# setup drails1
# works.
# https://www.phusionpassenger.com/library/deploy/apache/deploy/ruby/#deploying-an-app-to-a-sub-uri-or-subdirectory/

source shc/21env.sh
cd; set -x ; date

vhost9()
{
sudo tee /etc/apache2/sites-available/drails1.conf <<EOF
#
# works on vagrant ubuntu vm 2015-09-28_Mon_23.25-PM 
# http://10.4.15.100:1221/
# http://pmdsdata:1221/drails237a
# http://localhost:1221/
listen 1221
<VirtualHost *:1221>
    ServerName 127.0.0.1
    #ServerAlias www.example.com
    #ServerAdmin webmaster@localhost
    DocumentRoot "/var/www/html/rails/drails/public"
    RailsEnv development
    ErrorLog ${APACHE_LOG_DIR}/error-drails1.log
    CustomLog ${APACHE_LOG_DIR}/access-drails1.log combined
    <Directory "/var/www/html/rails/drails">
        Options FollowSymLinks
        Require all granted
    </Directory>

    #   sub dir app..
    Alias /drails237a "/var/www/html/rails/drails237a/public"
    <Location /drails237a>
        PassengerBaseURI /drails237a
        PassengerAppRoot "/var/www/html/rails/drails237a"
    </Location>
    <Directory "/var/www/html/rails/drails237a/public">
        Allow from all
        Options -MultiViews
        Options FollowSymLinks
        Require all granted
    </Directory>

    #   sub dir app..
    Alias /drail240a "/var/www/html/rails/drail240a/public"
    <Location /drail240a>
        PassengerBaseURI /drail240a
        PassengerAppRoot "/var/www/html/rails/drail240a"
    </Location>
    <Directory "/var/www/html/rails/drail240a/public">
        Allow from all
        Options -MultiViews
        Options FollowSymLinks
        Require all granted
    </Directory>

    #   sub dir app..
    Alias /cocoon238c "/var/www/html/rails/cocoon238c/public"
    <Location /cocoon238c>
        PassengerBaseURI /cocoon238c
        PassengerAppRoot "/var/www/html/rails/cocoon238c"
    </Location>
    <Directory "/var/www/html/rails/cocoon238c/public">
        Allow from all
        Options -MultiViews
        Options FollowSymLinks
        Require all granted
    </Directory>

</VirtualHost>
#
EOF
}


function examplefrompassenger() 
{
sudo tee /tmp/vh521221x5 <<EOF
<VirtualHost *:59810>
    ServerName www.phusion.nl
    DocumentRoot /websites/phusion/public
    <Directory /websites/phusion>
        Allow from all
        Options -MultiViews
        # Uncomment this if you're on Apache >= 2.4:
        #Require all granted
    </Directory>

    # These have been added:
    Alias /subapp /websites/secondapp/public
    <Location /subapp>
        PassengerBaseURI /subapp
        PassengerAppRoot /websites/secondapp
    </Location>
    <Directory /websites/secondapp/public>
        Allow from all
        Options -MultiViews
        # Uncomment this if you're on Apache >= 2.4:
        #Require all granted
    </Directory>
</VirtualHost>
EOF
}

apache9()
{
  sudo a2dissite drails1.conf
  sudo a2ensite drails1.conf
  sudo service apache2 restart
  sudo service apache2 reload
}

#main section...................................................................

#echo requested commands...
set -x ; date

vhost9
apache9

#
date
#
