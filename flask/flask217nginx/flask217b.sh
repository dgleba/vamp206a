#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:   nginx  uwsgi venv flask_admin auth example






see error below bad gateway.







-   localhost:952


# caution:
    # this changes the default nginx port from 80 to 82.


2fix.. cd;sudo ls; sudo shc/100/215nginxflaskad1.sh


https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uwsgi-and-nginx-on-ubuntu-14-04
# not.. https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-14-04



END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#main: 


# sudo apt-get update
sudo apt-get install python-pip python-dev nginx

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#change nginx default port to 82 so apache still works on 80..

#sudo leafpad /etc/nginx/sites-enabled/default
# orig settings...
#    listen 80 default_server;
#    listen [::]:80 default_server ipv6only=on;

# backup..
sudo cp  /etc/nginx/sites-enabled/default  /etc/nginx/sites-enabled/default.$(date "+%Y-%m-%d_%s").bk
sudo cp  /etc/nginx/sites-available/default  /etc/nginx/sites-available/default.$(date "+%Y-%m-%d_%s").bk
# remove line containing  '?????'  and replace the line completely with the new text...
nowdg1=`date +'__%Y-%m-%d_%a_%H.%M.%S-%Z'`
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

sudo mkdir -p /srv/web/flask217b
#
sudo chgrp -hR www-data /srv/web # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /srv/web 
# include sticky on group to preserve group on new file creation..
sudo chmod -R g+rws  /srv/web # writable for group
sudo chmod -R o-rw /srv/web # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /srv/web -type d -exec chmod g+x {} +
#
cd /srv/web/flask217b

# create readme
nowdg1=`date +'_%Y.%m.%d_%H.%M.%S'`
tee /srv/web/00readme.txt <<EOF
Purpose: for nginx served projects, and possibly other projects.
This folder - /srv/web
Made by David Gleba
echo $nowdg1
.
EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# copy example code

mkdir -p /tmp/dg
cd /tmp/dg
rm -rf /tmp/dg/flaskadm
git clone https://github.com/flask-admin/flask-admin.git flaskadm
cd ./flaskadm/examples/sqla
cp -a .  /srv/web/flask217b


#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd /srv/web/flask217b

sudo pip install virtualenv

cd /srv/web/flask217b
virtualenv flask217benv

cd /srv/web/flask217b
source flask217benv/bin/activate

pip install uwsgi flask
pip install -r 'requirements.txt'


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# create app flask217b
   
cd /srv/web/flask217b
mv app.py flask217b.py
rm app2.py

# expose dev app on all ip's ...   application.run(host='0.0.0.0')

# run in Dev..

#  python flask217b.py

#visit localhost:5000


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd /srv/web/flask217b
source flask217benv/bin/activate

#create flask217b.wsgi
tee /srv/web/flask217b/flask217b.wsgi <<EOF
#
from flask217b import app as application
if __name__ == "__main__":
    app.run()
#
EOF

#test uwsgi...
cd /srv/web/flask217b
 uwsgi --socket 0.0.0.0:8000 --protocol=http  -w flask217b --callable app

#visit localhost:8000 and use localip:8000 from another pc on the local network..

#error:
#unable to load app 0 (mountpoint='') (callable not found or import error)
#*** no app loaded. going in full dynamic mode ***
#*** uWSGI is running in multiple interpreter mode ***
#spawned uWSGI worker 1 (and the only) (pid: 3917, cores: 1)
#--- no python application found, check your startup logs for errors ---
#ans.
#http://stackoverflow.com/questions/12030809/flask-and-uwsgi-unable-to-load-app-0-mountpoint-callable-not-found-or-im
#uwsgi --socket 127.0.0.1:6000 --file /path/to/folder/run.py --callable app -  
#i added callable to the usgi call

# solved.

# see below for further problems..


deactivate

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#create uwsgi ini file..
tee /srv/web/flask217b/flask217b.ini <<EOF
[uwsgi]
module = flask217b
mount = ws/flask217b.py
callable = app
master = true
processes = 5
socket = flask217b.sock
chmod-socket = 660
vacuum = true
die-on-term = true
EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sudo tee /etc/init/flask217b.conf <<EOF
#
description "uWSGI server instance configured to serve myproject"
#
start on runlevel [2345]
stop on runlevel [!2345]
#
setuid www-data
setgid www-data
#
env PATH=/srv/web/flask217b/flask217benv/bin
chdir /srv/web/flask217b
exec uwsgi --ini flask217b.ini
#
EOF

sudo start flask217b


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sudo tee /etc/nginx/sites-available/flask217b <<EOF
#
server {
    listen 952;
    #worked.. server_name v206b1;
    server_name 127.0.0.1;
    #server_name v206b2.local;

    location / {
        include uwsgi_params;
        uwsgi_pass unix:/srv/web/flask217b/flask217b.sock;
    }
}
#
EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo ln -s /etc/nginx/sites-available/flask217b /etc/nginx/sites-enabled


sudo service flask217b restart
sudo service nginx restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

localhost:952

I got error 2016-01-23_Sat_11.48-AM

error 502 bad gateway
note that:     uwsgi nginx flask socket file not created


http://stackoverflow.com/questions/33586013/flask-app-on-uwsgi-nginx-unix-socket-file-is-not-created-on-booting


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# backup folder

sudo mkdir -p /home/file
sudo chgrp -hR www-data /home/file # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /home/file 
sudo chmod -R g+rws  /home/file # writable for group
sudo chmod -R o-rw /home/file # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /home/file -type d -exec chmod g+x {} +
#
cd /home/file
mkdir -p /home/file/backup
#
tar -cvzf /home/file/backup/flask217b.$(date +"%Y.%m.%d_%H.%M.%S").tgz  /srv/web/flask217b/ --exclude={flask217benv,backup,Trash/files,*.tgz} 


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#
date
#
