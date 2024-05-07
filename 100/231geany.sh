#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

#  main...

sudo apt-get -y install geany


# python code reformat.. http://wiki.geany.org/howtos/check_python_code
#    checks but doesn't fix.

#try yapf
sudo pep install yapf
yapf ei.py
# got indentation error. what????

sudo pip install autopep8
autopep8 -i ei.py
#works., no it didn't. it didn't reindent it.

# I can't find any tool in geany to reindent it.


#
date
#
