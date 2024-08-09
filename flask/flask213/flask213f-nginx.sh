#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:   nginx  gnuicorn venv supervisor,  flask-admin sqla example
                deploy with nginx after apache.
                from /var/www/html/python/flask213f

-   localhost:1214
        (gnuicorn 1215)

result:        works.

# caution:     # this changes the default nginx port from 80 to 82.

 cd;sudo ls; sudo   shc/apps/flask213/flask213fngx.sh

https://realpython.com/blog/python/kickstarting-flask-on-ubuntu-setup-and-deployment/
less so: http://alexandersimoes.com/hints/2015/10/28/deploying-flask-with-nginx-gunicorn-supervisor-virtualenv-on-ubuntu.html



END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#main: 

cd /var/www/html/python/flask213f


# sudo apt-get update
sudo apt-get -y install python-pip python-dev nginx
sudo apt-get -y install ufw python-dev python-virtualenv python-pip git nginx supervisor
sudo apt-get install -y python python-pip python-virtualenv nginx gunicorn  

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# stop it if it was already running...

sudo pkill gunicorn
sudo supervisorctl stop flask213f


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
sleep 1
sudo service nginx start
sudo service apache2 restart


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd /var/www/html/python/flask213f

sudo pip install virtualenv

cd /var/www/html/python/flask213f
virtualenv flask213fenv

cd /var/www/html/python/flask213f
source flask213fenv/bin/activate


pip install -r 'requirements.txt'


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# create app flask213f
   
  python flask213f.py

#visit localhost:5000


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

deactivate

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# I escape the $host with \$host here...

sudo tee /etc/nginx/sites-available/flask213f <<EOF
#
server {
    listen 1214;
    
    location / {
        proxy_pass http://localhost:1215;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
    #location /static {
    #    alias  /srv/web/flask213f/static/;
    #}
}
#
EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo ln -s /etc/nginx/sites-available/flask213f /etc/nginx/sites-enabled

sudo service nginx restart

cd /var/www/html/python/flask213f
gunicorn flask213f:app -b localhost:1215



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

localhost:1214

# ? works!



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# supervisor

sudo tee /etc/supervisor/conf.d/flask213f.conf <<EOF
#
[program:flask213f]
command = gunicorn flask213f:app -b localhost:1215
directory = /var/www/html/python/flask213f
user = albe
#
EOF


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo pkill gunicorn

#Start gunicorn with supervisor:

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl stop  flask213f
sudo supervisorctl start flask213f



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
tar -cvzf /home/file/backup/flask213f.$(date +"%Y.%m.%d_%H.%M.%S").tgz  /srv/web/flask213f/ --exclude={flask213fenv,backup,Trash/files,*.tgz} 


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#
date
#
