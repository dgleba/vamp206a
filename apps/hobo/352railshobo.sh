#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

result:
no joy just get welcom page, not hobo app.


#  Purpose:  install ruby on rails and Hobo

http://hobocentral.net/tutorials/two-minutes
2016-03-31

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


# install hobo like this, but i got errors.
#http://www.hobocentral.net/tutorials/two-minutes
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#so..
#follow...
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
gem install hobo

echo $HOBODEV
echo $(date +"%Y.%m.%d_%H.%M.%S")>> ~/hoboenv.info.dg.txt
echo $HOBODEV >> ~/hoboenv.info.dg.txt
# unset HOBODEV

cd ~ ; mkdir -p web ; cd web

gem install uglifier
#http://stackoverflow.com/questions/34420554/there-was-an-error-while-trying-to-load-the-gem-uglifier-bundlergemrequire
sudo apt-get -y install nodejs

hobo new noteshobo --setup
hobo new notes2 --setup

cd noteshobo

hobo g resource note name:string body:text
hobo g migration
#...Respond to the prompt with 'm'
#...then press enter to chose the default filename

rails s

# visit http://localhost:3000

# i just got the rails intro page.
# Welcome aboard You’re riding Ruby on Rails!


#

function offline() 
{
sleep 98765
sudo apt-get update
sudo apt-get install -y ruby1.9.3 nodejs libsqlite3-dev git
export GEM_HOME=$HOME/.gem
echo "export GEM_HOME=$HOME/.gem" >> .bashrc
PATH="$HOME/.gem/bin:$PATH"
echo 'PATH="$HOME/.gem/bin:$PATH"' >> .bashrc

gem install hobo
#got error... 
# ERROR:  Error installing hobo: 	mime-types-data requires Ruby version >= 2.0.
}

function offline2() 
{
sleep 98765
sudo apt-get update
#got error... 
# ERROR:  Error installing hobo: 	mime-types-data requires Ruby version >= 2.0.
}


#
date
#

