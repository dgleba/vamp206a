#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  install ruby on rails 







Do NOT run this scrpt as root!!!!!!!!










END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


####   !!!!   The following must be done as NON-root....

# i think this has to be done after exec $shell

 
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
echo 'gem: --no-document' >> ~/.gemrc

git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

#rbenv install 2.1.4
#rbenv global 2.1.4
# 2016-05-10 i think 2.3.0 will be ok next time... 
#rbenv install 2.3.0
#rbenv global 2.3.0

rbenv install 2.6.3
rbenv global 2.6.3

ruby -v

gem install bundler
rbenv rehash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

gem install rails -v 5.2.3 --no-document

gem install uglifier
#http://stackoverflow.com/questions/34420554/there-was-an-error-while-trying-to-load-the-gem-uglifier-bundlergemrequire

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#
date
#
