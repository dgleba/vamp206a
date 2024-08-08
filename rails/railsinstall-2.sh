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

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#http://stackoverflow.com/questions/26595620/how-to-install-ruby-2-1-4-on-ubuntu-14-04
#https://gorails.com/setup/ubuntu/14.04


####   !!!!   The following must be done as non-root....

cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# run this next time and..
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
#exec $SHELL
# and run it now..
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
#export RBENV_ROOT="$HOME/.rbenv"

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# run this next time and..
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
# and run it now..
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#http://stackoverflow.com/questions/26595620/how-to-install-ruby-2-1-4-on-ubuntu-14-04
#https://gorails.com/setup/ubuntu/14.04

# 2019-10-06 need this on pmdsdata4
sudo apt install ruby-build
cd /home/albe/.rbenv/plugins/ruby-build && git pull && cd -
