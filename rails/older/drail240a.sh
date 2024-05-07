#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  deploy drail240a
https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-unicorn-and-nginx-on-ubuntu-14-04

see error.txt



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
cp  /srv/web/drail240a/config/unicorn.rb  /srv/web/drail240a/config/unicorn.rb$(date +"__%Y.%m.%d_%H.%M.%S").bk
cd /srv/web/drail240a
sudo tee /srv/web/drail240a/config/unicorn.rb <<EOF
#
# set path to application
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir
# Set unicorn options
worker_processes 2
preload_app true
timeout 30
# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64
# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"
# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"
#
EOF


cd /srv/web/drail240a
mkdir -p shared/pids shared/sockets shared/log

set variables for tee. they will be in the script as well.
USER1="albe"
APP_NAME="drail240a"

sudo tee /etc/init.d/unicorn_drail240a <<EOF
#!/bin/sh
### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the unicorn app server
# Description:       starts unicorn using start-stop-daemon
#  /srv/web/drail240a/bundle install
### END INIT INFO
set -e
USAGE="Usage: \$0 <start|stop|restart|upgrade|rotate|force-stop>"
# app settings
USER1="albe"
APP_NAME="drail240a"
APP_ROOT="/srv/web/\$APP_NAME"
ENV="development"
# environment settings
PATH="/home/\$USER1/.rbenv/shims:/home/\$USER1/.rbenv/bin:\$PATH"
CMD="cd \$APP_ROOT && \$APP_ROOT/bin/bundle exec unicorn -c config/unicorn.rb -E \$ENV -D"
PID="\$APP_ROOT/shared/pids/unicorn.pid"
OLD_PID="\$PID.oldbin"
# make sure the app exists
cd \$APP_ROOT || exit 1
#
sig () {
  test -s "\$PID" && kill -$1 \`cat \$PID\`
}
#
oldsig () {
  test -s \$OLD_PID && kill -\$1 \`cat \$OLD_PID\`
}
#
case \$1 in
  start)
    sig 0 && echo >&2 "Already running" && exit 0
    echo "Starting \$APP_NAME"
    su - \$USER1 -c "\$CMD"
    ;;
  stop)
    echo "Stopping \$APP_NAME"
    sig QUIT && exit 0
    echo >&2 "Not running"
    ;;
  force-stop)
    echo "Force stopping \$APP_NAME"
    sig TERM && exit 0
    echo >&2 "Not running"
    ;;
  restart|reload|upgrade)
    sig USR2 && echo "reloaded \$APP_NAME" && exit 0
    echo >&2 "Couldn't reload, starting '\$CMD' instead"
    \$CMD
    ;;
  rotate)
    sig USR1 && echo rotated logs OK && exit 0
    echo >&2 "Couldn't rotate logs" && exit 1
    ;;
  *)
    echo >&2 \$USAGE
    exit 1
    ;;
esac
#
EOF

#Update the script's permissions and enable Unicorn to start on boot:
sudo chmod 755 /etc/init.d/unicorn_drail240a
sudo update-rc.d unicorn_drail240a defaults

sudo service unicorn_drail240a start

sudo apt-get -y install nginx



sudo tee /etc/nginx/sites-available/drail240a.conf <<EOF
#
upstream app {
    # Path to Unicorn SOCK file, as defined previously
    server unix:/srv/web/drail240a/shared/sockets/unicorn.sock fail_timeout=0;
}

server {
    listen 1222;
    server_name localhost;

    root /srv/web/drail240a/public;

    try_files $uri/index.html $uri @app;

    location @app {
        proxy_pass http://app;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header Host \$http_host;
        proxy_redirect off;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}
#
EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#change nginx      default port     to 82 so apache still works on 80..

#sudo leafpad /etc/nginx/sites-enabled/default
# orig settings...
#    listen 80 default_server;
#    listen [::]:80 default_server ipv6only=on;

# backup..
sudo cp  /etc/nginx/sites-enabled/default  /etc/nginx/sites-enabled/default.$(date "+%Y-%m-%d_%s").bk
sudo cp  /etc/nginx/sites-available/default  /etc/nginx/sites-available/default.$(date "+%Y-%m-%d_%s").bk
# remove line containing  '?????'  and replace the line completely with the new text...
nowdg1=`date +'__%Y-%m-%d_%a_%H.%M.%S-%Z'`
sudo sed -i "/.*listen 80 .*/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/nginx/sites-available/default # add marker above the change.
#Use double quotes to make the shell expand variables while keeping whitespace:
sudo sed -i "s/.*listen 80 .*/       listen 82 default_server;/g" /etc/nginx/sites-available/default
sudo sed -i "s/.*80 default_server.*/       listen [::]:82 default_server ipv6only=on;/g" /etc/nginx/sites-available/default
# cat /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-enabled/default
sudo ln -nfs /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# move unneeded config out of the way...
sudo mkdir /etc/nginx/offlinedg
#sudo mv  /etc/nginx/sites-available/default /etc/nginx/offlinedg/default
sudo mv /etc/nginx/sites-enabled/*.bak /etc/nginx/offlinedg
sudo mv /etc/nginx/sites-enabled/*.bk /etc/nginx/offlinedg

sudo service nginx stop
sleep 1
sudo service nginx start
sudo service apache2 restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo service nginx restart

#
date
#
