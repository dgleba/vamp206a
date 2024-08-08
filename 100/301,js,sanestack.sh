#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  Install javascript stack(s)


http://askubuntu.com/questions/594656/how-to-install-the-latest-versions-of-nodejs-and-npm-for-ubuntu-14-04-lts


http://stackoverflow.com/questions/32426601/completly-uninstall-nodejs-npm-and-node-in-ubuntu-14-04
I would recommend installing node using Node Version Manager(NVM). That saved a lot of head ache for me. Because you can install nodejs and npm without sudo using nvm.


https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#
# Main: put code here...

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo ls

# remove it...
 npm uninstall -g sails 
 npm uninstall -g ember-cli 
 npm uninstall -g sane-cli 
# remove...
sudo npm uninstall -g sails 
sudo npm uninstall -g ember-cli 
sudo npm uninstall -g syane-cli 
sudo apt-get remove nodejs
sudo apt-get remove npm
sudo apt-get purge nodejs npm
sudo apt-get update
sudo apt-get autoremove

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#install nvm
# i didn't use nvm...
sudo apt-get -y install build-essential libssl-dev
#You should check the GitHub project page for the latest release of NVM, 
#   https://github.com/creationix/nvm/releases
#      edit v0.31.0 .....
curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
source ~/.profile
nvm --version
#http://www.liquidweb.com/kb/how-to-install-nvm-node-version-manager-for-node-js-on-ubuntu-14-04-lts/


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#worked...

#http://sailsjs.org/get-started
sudo apt-get -y install python-software-properties python g++ make

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

#https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04
nvm install 6.0.0

nvm use 6.0.0

nvm ls


#curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
#sudo apt-get -y install  nodejs

# i didn't use 5.x...
#curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
#sudo apt-get install -y nodejs

#already there, no need... sudo apt-get install npm


#nonoworks:
#sudo npm install -g node 

npm install -g sails 
#sudo npm install -g ember-cli 
npm install -g sane-cli 


#https://askubuntu.com/questions/786272/why-does-installing-node-6-x-on-ubuntu-16-04-actually-install-node-4-2-6
#sudo apt-get purge nodejs npm
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

node -v
nvm --version
npm -v
sails -v


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
date
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# install mongodb


#yes:  https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-mongodb-on-ubuntu-16-04
#no:       https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-16-04

#sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

#echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list


sudo apt-get update

sudo apt-get -y install  mongodb-org


# create service file

mkdir -p $HOME/backup
file1="/etc/systemd/system/mongodb.service"
if [ ! -f $file1.orig ] ; then sudo cp $file1 $HOME/backup/$file1.orig ; fi
#back it up with a unique name using a timestamp..
sudo cp $file1 $HOME/backup/$file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt
ls $HOME/backup

sudo tee /etc/systemd/system/mongodb.service <<HEREDOC
[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target

[Service]
User=mongodb
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target
HEREDOC

cat /etc/systemd/system/mongodb.service


sudo ufw allow 27017


sudo systemctl stop mongodb
sudo systemctl start mongodb

sudo systemctl enable mongodb

sudo systemctl status mongodb

sudo ufw status

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
date
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mongo
#exit

use admin
db.createUser(
  {
    user: "Admins",
    pwd: "astrongpassword",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


sudo nano /etc/mongod.conf
#In the #security section, we'll remove the hash in front of security to enable the stanza. Then we'll add the authorization setting. When we're done, the lines should look like the excerpt below:

# must have two spaces after security line..

#mongodb.conf
#. . .
security:
  authorization: "enabled"

sudo systemctl restart mongodb
sudo systemctl status mongodb



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
date
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# get error as regular user..
mongo
show dbs
exit

# sign in as admin to check it..

mongo -u Admins -p --authenticationDatabase admin
show dbs
exit


#https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-mongodb-on-ubuntu-16-04

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
date
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

