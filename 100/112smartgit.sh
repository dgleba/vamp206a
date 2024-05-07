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

# Main: put code here...

sudo add-apt-repository ppa:eugenesan/ppa
sudo apt-get update
sudo apt-get install -y  smartgithg

# note: this will install ‘jdk-8u51-linux-x64.tar.gz’

# see menu item.. start / programming / smartgit

# notes:
cd /usr/bin/....fix this ...
./smartgithg
/usr/share/smartgit/bin/smartgit.sh


#
date
#
