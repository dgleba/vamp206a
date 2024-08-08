#!/bin/bash
# install rails on mac osx
# https://gorails.com/setup/osx/10.10-yosemite

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install rbenv ruby-build

# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby
rbenv install 2.3.0
rbenv global 2.3.0
ruby -v


#Configuring Git


git config --global color.ui true
git config --global user.name "dgleba"
git config --global user.email "dgleba@gmail.com"
ssh-keygen -t rsa -C "dgleba@gmail.com"
# The next step is to take the newly generated SSH key and add it to your Github account. You want to copy and paste the output of the following command and paste it here.


cat ~/.ssh/id_rsa.pub

# paste at:
https://github.com/settings/ssh



# Once you've done this, you can check and see if it worked:
ssh -T git@github.com

gem install rails -v 4.2.6

rbenv rehash

rails -v
# Rails 4.2.6

brew install mysql

# To have launchd start mysql at login:
ln -sfv /usr/local/opt/mysql/*plist ~/Library/LaunchAgents

# Then to load mysql now:
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist


# PostgreSQL

brew install postgresql

# To have launchd start postgresql at login:
ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents

# Then to load postgresql now:
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
# By default the postgresql user is your current OS X username with no password. For example, my OS X user is named chris so I can login to postgresql with that username.


rails new myapp

#### If you want to use MySQL
# rails new myapp -d mysql

#### If you want to use Postgres
# Note you will need to change config/database.yml's username to be
# the same as your OSX user account. (for example, mine is 'chris')
# rails new myapp -d postgresql

# Move into the application directory
cd myapp

# If you setup MySQL or Postgres with a username/password, modify the
# config/database.yml file to contain the username/password that you specified

# Create the database
rake db:create

rails server

