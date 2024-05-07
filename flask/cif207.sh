#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#Purpose:  flask cif216 ci listing app in flask, start with flaskadmin auth example
hmm, i called it cif207.

http://v206b1:920/admin/#

shc/apps/flask213/cif207.sh

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#main...

mkdir -p /var/www/html/python/
cd       /var/www/html/python/

git clone https://github.com/dgleba/cif207.git cif207
cd cif207

sudo pip install -r 'requirements.txt'

# the app throws an error when it is called app.py, rename it...
#file "/var/www/html/python/apache/cif207.wsgi", line 5, in <module> [:error] [pid 6602] from app import app as application [:error] ImportError: No module named app
#mv /var/www/html/python/cif207/examples/sqla/app.py /var/www/html/python/cif207/examples/sqla/app1.py

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# htaccess -- not working.
#
# redirect to 918 if "cif207/" is matched. so localhost/cif207/ redirects to: localhost:917
#
# logging: /etc/apache2/apache2.conf >  LogLevel alert rewrite:trace3  | tail -f /var/log/apache2/error.log|fgrep '[rewrite:'
#
#cat <<EOF > /var/www/html/python/cif207/.htaccess
#
# redirect to 920 if "cif207" is matched
#RewriteEngine on
#Options +FollowSymLinks
##RewriteBase /
#RewriteRule ^(cif207)\/(.+)$ http://localhost/$2 [R=301]#
#EOF
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# deployment
#
# deploy with apache...
#
mkdir -p /var/www/html/python/apache
cat <<EOF > /var/www/html/python/apache/cif207.wsgi
import sys
sys.stdout = sys.stderr
# path is in vhost file, not here like in docs at..  http://flask.pocoo.org/docs/0.10/deploying/mod_wsgi/#creating-a-wsgi-file
# sys.path.insert(0, '/var/www/html/python/cif207')
from cif207 import app as application
EOF

# virtual host config for apache is here... run it ...
source ~/shc/52-v/52vh920.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# start dev server . visit localhost:5000
#python /var/www/html/python/cif207/cif207.py

#show apache log..
sudo tail /var/log/apache2/error.log

#
