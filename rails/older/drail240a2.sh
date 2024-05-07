#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  deploy drail240a
#  

http://www.rubytreesoftware.com/resources/ruby-on-rails-41-ubuntu-1404-server-configuration/

http://www.rubytreesoftware.com/resources/ruby-on-rails-41-ubuntu-1404-server-deployment


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

#backup..
sudo cp  /srv/web/drail240a/config/unicorn2.rb  /srv/web/drail240a/config/unicorn2.rb$(date +"__%Y.%m.%d_%H.%M.%S").bk
cd /srv/web/drail240a
sudo tee /srv/web/drail240a/config/unicorn2.rb <<EOF
#
root = "/srv/web/drail240a"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.drail240a2.sock"
worker_processes 1
timeout 30
#
EOF


cd /srv/web/drail240a
mkdir -p /srv/web/drail240a/tmp/pids /srv/web/drail240a/tmp/log

set variables for tee. they wilnl be in the script as well.
# USER1="albe"
# APP_NAME="drail240a"

 
#backup..
sudo cp  /etc/init.d/unicorn_drail240a2  /etc/init.d/unicorn_drail240a2$(date +"__%Y.%m.%d_%H.%M.%S").bk
# copy file into place
sudo cp  /home/albe/shc/apps/rails/drail240a2.initd.txt /etc/init.d/unicorn_drail240a2




#Update the script's permissions and enable Unicorn to start on boot:
sudo chmod 755 /etc/init.d/unicorn_drail240a2
sudo update-rc.d unicorn_drail240a2 defaults

sudo service unicorn_drail240a2 start

sudo apt-get -y install nginx



s /etc/nginx/sites-available/drail240a.conf 
#backup..
sudo cp  /etc/nginx/sites-available/drail240a2.conf  /etc/nginx/sites-available/drail240a2.conf$(date +"__%Y.%m.%d_%H.%M.%S").bk
# copy file into place
sudo cp  /home/albe/shc/apps/rails/drail240a2.nginx.txt  /etc/nginx/sites-available/drail240a2.conf

sudo ln -nfs /etc/nginx/sites-available/drail240a2.conf /etc/nginx/sites-enabled/drail240a2.conf


sudo service nginx restart

#
date
#
