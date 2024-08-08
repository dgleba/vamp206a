#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  

replace string in all files recursively...


ref.
http://stackoverflow.com/questions/1583219/awk-sed-how-to-do-a-recursive-find-replace-of-a-string


END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


# example..
#find /home/www3 -type f -print0 | xargs -0 sed -i 's/subdomainA.example.com/subdomainB.example.com/g'
#

#find /var/www/html/django/dj224testg -type f -print0 | xargs -0 sed -i 's/ci-site/dj224testg/g'

find /var/www/html/django/dj224c -type f -print0 | xargs -0 sed -i 's/dj162/dj224c/g'




#
date
#
