#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#Purpose:  flask admin examples sqla - test the apache deployment.

flask213f port 921

ref:
https://github.com/petrus-jvrensburg/flask-admin-examples
http://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-xvii-deployment-on-linux-even-on-the-raspberry-pi

shc/apps/flask213/flask213f.sh


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#main...


# flask admin
#   https://github.com/flask-admin/Flask-Admin/tree/master/examples/sqla

mkdir -p /var/www/html/python/flask213f/apache

mkdir -p /tmp/dg/
cd /tmp/dg/
git clone https://github.com/flask-admin/flask-admin.git flaskadm
cd ./flaskadm/examples/sqla
cp -a .  /var/www/html/python/flask213f

cd /var/www/html/python/flask213f


sudo pip install -r 'requirements.txt'

# the app throws an error when it is called app.py, rename it...
#file "/var/www/html/python/apache/flask213e.wsgi", line 5, in <module> [:error] [pid 6602] from app import app as application [:error] ImportError: No module named app
mv app.py flask213f.py

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# htaccess
#
# redirect to 921 if "flask213f/" is matched. so localhost/flask213f/ redirects to: localhost:917
#
# logging: /etc/apache2/apache2.conf >  LogLevel alert rewrite:trace3  | tail -f /var/log/apache2/error.log|fgrep '[rewrite:'

# no luck with this yet..

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# deployment
#
# deploy with apache...
#
cat <<EOF > /var/www/html/python/flask213f/apache/flask213f.wsgi
import sys
sys.stdout = sys.stderr
# path is in vhost file, not here like in docs at..  http://flask.pocoo.org/docs/0.10/deploying/mod_wsgi/#creating-a-wsgi-file
# sys.path.insert(0, '/var/www/html/python/flask21xx')
from flask213f import app as application
EOF

# virtual host config for apache is here... run it ...
source ~/shc/52-v/52vh921.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# start dev server . visit localhost:5000
python /var/www/html/python/flask213f/flask213f.py

#show apache log..
sudo tail /var/log/apache2/error.log

#
