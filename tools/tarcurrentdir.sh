#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  tar the current folder and give the archive a useful name..

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#cd ; 
date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...

mkdir -p tmp/dglog
mv log/development.log tmp/dglog/development.log.$(date +"__%Y.%m.%d_%H.%M.%S").log
###### tar current folder..
base=$(basename $PWD);export HOSTNAME;cd ..
tar -czf $base-$HOSTNAME$(date +"__%Y.%m.%d_%H.%M.%S").tgz  $base --exclude={$base/tmp,$base/vendor/assets/javascripts,$base/shared,$base/nbproject,$base/log};cd $base

#
date
#
