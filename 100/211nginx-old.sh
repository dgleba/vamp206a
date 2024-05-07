#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:   nginx postgres gnuicorn etc..







    this one uses different names:  env217 hello217a










# no.. https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-14-04

https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uwsgi-and-nginx-on-ubuntu-14-04

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#main: 

sudo apt-get update
sudo apt-get install python-pip python-dev nginx

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#change nginx default port to 82 so apache still works on 80..

#sudo leafpad /etc/nginx/sites-enabled/default
# old settings...
#    listen 80 default_server;
#    listen [::]:80 default_server ipv6only=on;

# backup..
#oops forgot to backup, this fixes it.... sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
sudo cp  /etc/nginx/sites-enabled/default  /etc/nginx/sites-enabled/default.$(date "+%Y-%m-%d_%s").bk
sudo cp  /etc/nginx/sites-available/default  /etc/nginx/sites-available/default.$(date "+%Y-%m-%d_%s").bk
# remove line containing  'vamp206b'  and replace the line completely with the new text...
nowdg1=`date +'__%Y-%m-%d_%a_%k.%M.%S-%Z'`
sudo sed -i "/.*listen 80 .*/i # \n# David Gleba kdg54 $nowdg1 ...\n#"  /etc/nginx/sites-enabled/default # add marker above the change.
#Use double quotes to make the shell expand variables while keeping whitespace:
sudo sed -i "s/.*listen 80 .*/       listen 82 default_server;/g" /etc/nginx/sites-enabled/default
sudo sed -i "s/.*80 default_server.*/       listen [::]:82 default_server ipv6only=on;/g" /etc/nginx/sites-enabled/default

cat /etc/nginx/sites-enabled/default

# move unneeded config out of the way...
sudo mkdir /etc/nginx/offlinedg
sudo mv  /etc/nginx/sites-available/default /etc/nginx/offlinedg/default
sudo mv /etc/nginx/sites-enabled/*.bk /etc/nginx/offlinedg

sudo service nginx stop
sleep 3
sudo service nginx start
sudo service apache2 restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# make folder and change permissions...
# my standard practice for shared web stuff...

sudo mkdir -p /srv/nginx/flask217a
#
sudo chgrp -hR www-data /srv # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /srv 
sudo chmod -R g+rw  /srv # writable for group
sudo chmod -R o-rw /srv # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /srv -type d -exec chmod g+x {} +
#
cd /srv/nginx/flask217a
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo pip install virtualenv

virtualenv env217a
source env217a/bin/activate
pip install uwsgi flask


# create app hello217a
tee /srv/nginx/flask217a/hello217a.py <<EOF
from flask import Flask
application = Flask(__name__)
@application.route("/")
def hello():
    return "<h1 style='color:blue'>Hello There!</h1>"
if __name__ == "__main__":
    application.run(host='0.0.0.0')
EOF

python hello217a.py

#visit localhost:5000

#create hello217a.wsgi
tee /srv/nginx/flask217a/hello217a.wsgi <<EOF
from hello217a import application
if __name__ == "__main__":
    application.run()
EOF

#test uwsgi...
uwsgi --socket 0.0.0.0:8000 --protocol=http -w hello217a

#visit localhost:8000 and use localip:8000 from another pc on the local network..

deactivate.

#create uwsgi ini file..
tee /srv/nginx/flask217a/hello217a.ini <<EOF
[uwsgi]
module = hello217a
master = true
processes = 5
socket = hello217a.sock
chmod-socket = 660
vacuum = true
die-on-term = true
EOF



#
date
#
