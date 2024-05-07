#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  deploy drails237a

i believe rails was installed in 353railshobo.sh


https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-apache-on-ubuntu-14-04

https://codepen.io/asommer70/post/installing-ruby-rails-and-passenger-on-ubuntu-an-admin-s-guide

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...

#install passenger
#sudo rm /etc/apt/sources.list.d/passenger.list
sudo sh -c 'echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" >> /etc/apt/sources.list.d/passenger.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
sudo apt-get update
sudo apt-get install build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev libsqlite3-dev sqlite3
sudo apt-get install libapache2-mod-passenger
sudo a2enmod passenger
sudo service apache2 restart



sudo tee /etc/apache2/mods-available/passenger.conf <<EOF
#
<IfModule mod_passenger.c>
    PassengerRoot /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini
    PassengerDefaultRuby $HOME/.rbenv/shims/ruby
</IfModule>
#
#---
#
EOF


# now run 52vh1221.sh

# i did it differently than this...
#This step will overwrite our Ruby version to an older one. To resolve this, simply remove the incorrect Ruby location and create a new symlink to the correct Ruby binary file:
#sudo rm /usr/bin/ruby
#sudo ln -s /usr/local/bin/ruby /usr/bin/ruby

#reference...
#install rails with no rdoc to save space.
#sudo gem install --no-rdoc --no-ri rails





#
date
#
