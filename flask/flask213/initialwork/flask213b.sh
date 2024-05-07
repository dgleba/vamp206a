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

About flask admin...

https://flask-admin.readthedocs.org/en/latest/advanced/#migrating-from-django

The design philosophy behind Flask is slightly different. Rather than making it very 
easy to build an application that almost solves your whole problem, and then letting 
you figure out the last bit, Flask aims to make it possible for you to build the 
whole application. It might take a little more effort to get started, but once 
you’ve got the hang of it, the sky is the limit... 
_____________

http://mrjoes.github.io/2015/06/17/flask-admin-120.html

Making Assumptions
Flask-Admin uses default Bootstrap skin for a simple reason: 
I did not want to make strong assumptions for the developer related to look and 
feel of his UI and didn't want to complicate his life when he'll decide to make 
his interface look differently.
Other points:
--Bootstrap is lesser evil when compared to custom CSS framework and gives lots of 
building blocks right away,
--Yes, default Bootstrap skin looks boring (and maybe unprofessional),
--Yes, it is easy to switch to a custom Bootstrap skin,
...
    read more of it...
_____________



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
error:

mkdir: cannot create directory ‘flask213b’: File exists
cd flask213b
+ cd flask213b
virtualenv env213b
+ virtualenv env213b
New python executable in env213b/bin/python
Installing setuptools, pip, wheel...done.

. env213b/bin/activate
+ . env213b/bin/activate
# This file must be used with "source bin/activate" *from bash*
# you cannot run it directly
deactivate () {
    unset pydoc

_____________

note:

if i copy and paste it it works.
I get this error if I run the script.


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#main...

# flask213b
# first flask 2016-01-10_Sun_20.13-PM 2016-01-07_Thu_19.14-PM

sudo pip install virtualenv

cd /var/www/html
mkdir -p python
cd python

mkdir flask213b
cd flask213b
virtualenv env213b

. env213b/bin/activate

pip install Flask

#create hello1.py ...

cat <<EOF >> hello1.py
from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello_world():
    return 'Hello World! -flask213'
if __name__ == '__main__':
    app.run()
EOF

#visit:
#    http://127.0.0.1:5000/
#works.

python hello1.py

