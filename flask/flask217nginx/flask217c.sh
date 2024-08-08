#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:   nginx  gnuicorn  supervisor venv,  flask-admin sqla example
                from /srv/web/flask217c


-   localhost:1212     

result:
        works.
        

# caution:
    # this changes the default nginx port from 80 to 82.


 cd;sudo ls; sudo   shc/apps/flask217nginx/flask217c.sh

 
 
(i got error using 956 for gnuicorn - it would not start:
        2016-02-06 17:50:17 [8719] [ERROR] Can't connect to ('localhost', 956)

        

fabric deployment didn't work, do it manually...

https://realpython.com/blog/python/kickstarting-flask-on-ubuntu-setup-and-deployment/

less so: http://alexandersimoes.com/hints/2015/10/28/deploying-flask-with-nginx-gunicorn-supervisor-virtualenv-on-ubuntu.html


https://scottlinux.com/2014/04/03/how-to-host-multiple-django-or-python-apps-on-the-same-host-with-nginx-and-gunicorn/


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#main: 


# sudo apt-get update
sudo apt-get -y install python-pip python-dev nginx
sudo apt-get -y install ufw python-dev python-virtualenv python-pip git nginx supervisor
sudo apt-get install -y python python-pip python-virtualenv nginx gunicorn  

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# stop it if it was already running...

sudo pkill gunicorn
sudo supervisorctl stop flask217c


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
sudo mv /etc/nginx/sites-enabled/*.bak /etc/nginx/offlinedg
sudo mv /etc/nginx/sites-enabled/*.bk /etc/nginx/offlinedg

sudo service nginx stop
sleep 1
sudo service nginx start
sudo service apache2 restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#useradd deploy
#     mkdir /home/deploy
#     chown deploy:deploy /home/deploy
#     usermod -a -G sudo deploy
#     passwd deploy
#     chsh -s /bin/bash deploy

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# make folder and change permissions...
# my standard practice for shared web stuff...

sudo mkdir -p /srv/web/flask217c
#
sudo chgrp -hR www-data /srv/web # change group to www-data ( apache group. apache already was installed.)
sudo chown -R root /srv/web 
# include sticky on group to preserve group on new file creation..
sudo chmod -R g+rws  /srv/web # writable for group
sudo chmod -R o-rw /srv/web # not viewable for others..
# make only folders +x so they can be cd into.
sudo find /srv/web -type d -exec chmod g+x {} +
#
cd /srv/web/flask217c


## create readme
#nowdg1=`date +'_%Y.%m.%d_%H.%M.%S'`
#tee /srv/web/00readme.txt <<EOF
#Purpose: for nginx served projects, and possibly other projects.
#This folder - /srv/web
#Made by David Gleba
#echo $nowdg1
#.
#EOF


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# copy example code

mkdir -p /tmp/dg
cd /tmp/dg
#rm -rf /tmp/dg/flaskadm
git clone https://github.com/flask-admin/flask-admin.git flaskadm
cd ./flaskadm/examples/sqla
cp -a .  /srv/web/flask217c


#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#cd /srv/web
#git clone https://github.com/alexandersimoes/flaskdeploy.git

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd /srv/web/flask217c

sudo pip install virtualenv

cd /srv/web/flask217c
virtualenv flask217cenv

cd /srv/web/flask217c
source flask217cenv/bin/activate

#pip install uwsgi flask
pip install -r 'requirements.txt'


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# create app flask217c
   
cd /srv/web/flask217c
mv app.py flask217c.py
rm app2.py

# expose dev app on all ip's ...   application.run(host='0.0.0.0')

# run in Dev..

  python flask217c.py

#visit localhost:5000


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#cd /srv/web/flask217c
#source flask217cenv/bin/activate
#
##create flask217c.wsgi
#tee /srv/web/flask217c/flask217c.wsgi <<EOF
##
#from flask217c import app as application
#if __name__ == "__main__":
#    app.run()
##
#EOF
#

deactivate

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# I escape the $host with \$host here...

sudo tee /etc/nginx/sites-available/flask217c <<EOF
#
server {
    listen 1212;
    
    location / {
        proxy_pass http://localhost:1213;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
    #location /static {
    #    alias  /srv/web/flask217c/static/;
    #}
}
#
EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo ln -s /etc/nginx/sites-available/flask217c /etc/nginx/sites-enabled

sudo service nginx restart

cd /srv/web/flask217c
gunicorn flask217c:app -b localhost:1213



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

localhost:1212

#works!



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# supervisor

sudo tee /etc/supervisor/conf.d/flask217c.conf <<EOF
#
[program:flask217c]
command = gunicorn flask217c:app -b localhost:1213
directory = /srv/web/flask217c
user = albe
#
EOF


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo pkill gunicorn

#Start gunicorn with supervisor:

sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl stop  flask217c
sudo supervisorctl start flask217c



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
tar -cvzf /home/file/backup/flask217c.$(date +"%Y.%m.%d_%H.%M.%S").tgz  /srv/web/flask217c/ --exclude={flask217cenv,backup,Trash/files,*.tgz} 


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#
date
#
