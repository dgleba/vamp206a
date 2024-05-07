#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline()
{
exit 999
# begin block comment =============================
: <<'END'
_____________

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#


#main...


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# flask admin
#   https://github.com/flask-admin/Flask-Admin/tree/master/examples/sqla

cd /var/www/html/python

git clone https://github.com/flask-admin/flask-admin.git flaskad213c
cd flaskad213c

virtualenv env213c
source env213c/bin/activate

pip install -r 'examples/sqla/requirements.txt'

python examples/sqla/app.py

#

