#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  install ruby on rails 



usage:    shc/rails/railins.sh



Do NOT run this scrpt as root!!!!!!!!




notes:

http://codereview.stackexchange.com/questions/129343/install-ruby-using-rbenv-in-bash-script

https://github.com/fesplugas/rbenv-installer/blob/master/bin/rbenv-installer

https://relativkreativ.at/articles/how-to-automate-rbenv-installations

http://stackoverflow.com/questions/21589745/install-rbenv-using-ansible

http://stackoverflow.com/questions/21589745/install-rbenv-using-ansible



END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



source  shc/rails/railsinstall-1root.sh
sleep 4
source  shc/rails/railsinstall-2.sh
source exec $SHELL
source ~/.bashrc
sleep 4
source  shc/rails/railsinstall-3.sh
source exec $SHELL
source ~/.bashrc

