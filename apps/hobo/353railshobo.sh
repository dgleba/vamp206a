#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

works!

#  Purpose:  install ruby on rails and Hobo

http://www.hobocentral.net/tutorials/screencast

2016-03-31

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# install hobo like this.. http://www.hobocentral.net/tutorials/two-minutes - but i got errors.
#so.. follow...
#http://stackoverflow.com/questions/26595620/how-to-install-ruby-2-1-4-on-ubuntu-14-04
#https://gorails.com/setup/ubuntu/14.04

sudo apt-get update
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.1.4
rbenv global 2.1.4
ruby -v

gem install bundler
rbenv rehash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
railsgem uninstall hobo 

gem install hobo -v 2.2.3

echo $HOBODEV
echo $(date +"%Y.%m.%d_%H.%M.%S")>> ~/hoboenv.info.dg.txt
echo $HOBODEV >> ~/hoboenv.info.dg.txt
# unset HOBODEV


gem install uglifier
#http://stackoverflow.com/questions/34420554/there-was-an-error-while-trying-to-load-the-gem-uglifier-bundlergemrequire
sudo apt-get -y install nodejs

cd ~ ;  mkdir -p web ; cd web
hobo new trinote --setup

#see video...  http://www.hobocentral.net/tutorials/screencast

cd trinote
# rails s
# visit http://localhost:3000
#make admin user using the form...

# hobo g resource tnote name:string body:text
# hobo g migration
#...Respond to the prompt with 'm'
#...then press enter to chose the default filename


function csd-v206bflask1-error() 
{
sleep 98765
ls

on v206bflask1 at csd:  2016-04-01_Fri_15.34-PM
rails s

error:
    incompatible library version - /home/ /.gem/gems/nokogiri-1.6.7.2/lib/nokogiri/nokogiri.so (LoadError)
ggl:
    rails server incompatible library version - /home/ /.gem/gems/nokogiri /lib/nokogiri/nokogiri.so (LoadError)
try:
    gem uninstall nokogiri
    gem install nokogiri
result:
    fixed!!!
_____________
    
hobo new notes3 --setup
cd notes3 ; rails s

error..
try:
    gem pristine --all
cd ..
hobo new notes4 --setup
cd notes4 ; rails s
    result:
        fixed!
 
It starts, but there are errors when using the app. 
}

#
date
#
