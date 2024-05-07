#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#Purpose:  flask prodrptdb app in flask, start with flaskadmin auth example

ip:922
http://v206b1:922/admin/#

 shc/flask/pdb218.sh

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#main...

mkdir -p /var/www/html/python/
cd       /var/www/html/python/

git clone https://github.com/dgleba/pdb218.git pdb218
cd pdb218

sudo pip install -r 'requirements.txt'

# the app throws an error when it is called app.py, rename it...
#file "/var/www/html/python/apache/cif207.wsgi", line 5, in <module> [:error] [pid 6602] from app import app as application [:error] ImportError: No module named app
#mv /var/www/html/python/cif207/examples/sqla/app.py /var/www/html/python/cif207/examples/sqla/app1.py

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# deployment

#
# deploy with apache...
#

# make wsgi file.

mkdir -p /var/www/html/python/apache
cat <<EOF > /var/www/html/python/apache/pdb218.wsgi
import sys
sys.stdout = sys.stderr
# path is in vhost file, not here like in docs at..  http://flask.pocoo.org/docs/0.10/deploying/mod_wsgi/#creating-a-wsgi-file
# sys.path.insert(0, '/var/www/html/python/pdb218')
from pdb218 import app as application
EOF

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# make vhost

sudo tee /etc/apache2/sites-available/vhost922.conf <<EOF
############
#
# http://10.4.11.19:922
# http://l10.4.10.141:922
# http://192.168.88.58:922
# http://v206b1:922/
# http://localhost:922
#
listen 922
<VirtualHost *:922>
    #AllowOverride All
    DocumentRoot /var/www/html/python/pdb218
    ServerName 127.0.0.1
    #
    WSGIDaemonProcess pdb218 user=albe group=www-data processes=1 threads=5 python-path=/var/www/html/python/pdb218
    WSGIProcessGroup pdb218
    WSGIApplicationGroup %{GLOBAL}
    #
    WSGIScriptAlias / /var/www/html/python/apache/pdb218.wsgi
    #
    #allow access to wsgi file...
    <Directory /var/www/html/python/apache>
       Order deny,allow
       Allow from all
     </Directory>
     # deny directory listing of this folder... http://localhost:922
    <Directory /var/www/html/python/pdb218>
       AllowOverride All
       Order deny,allow
       Deny from all
     </Directory>
</VirtualHost>
############
#
EOF


  sudo a2dissite vhost922.conf
  sudo a2ensite vhost922.conf
  #sudo service apache2 restart
  sudo service apache2 reload


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


git pull https://github.com/dgleba/pdb218.git 

# start dev server . visit localhost:5000
#python /var/www/html/python/pdb218/pdb218.py

#show apache log..
#sudo tail /var/log/apache2/error.log

#
