#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  deploy drail240a
#  

bouugna

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#
# Main: put code here...

# edit in gemfile.. gem 'unicorn'
cd /srv/web/drail240a
bundle install
bundler

cd /srv/web/drail240a
mkdir -p /srv/web/drail240a/shared/pids /srv/web/drail240a/shared/log /srv/web/drail240a/shared/sockets

sudo apt-get -y install nginx


####s /etc/nginx/sites-available/drail240a.conf 
#backup..
sudo cp  /etc/nginx/sites-available/drail240a3.conf  /etc/nginx/sites-available/drail240a3.conf$(date +"__%Y.%m.%d_%H.%M.%S").bk
# copy file into place
sudo cp  /home/albe/shc/apps/rails/drail240a3.conf.nginx.vhost /etc/nginx/sites-available/drail240a3.conf

sudo ln -nfs /etc/nginx/sites-available/drail240a3.conf /etc/nginx/sites-enabled/drail240a3.conf

sudo service nginx restart

#
date
#
