#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'


#  usage         cd ; shc/100/303a-nodejs-stack.sh 2>&1 | tee -a 303a-nodejs_log$(date +"__%Y-%m-%d_%H.%M.%S").log ; exec bash


    # then..
                 exec bash 
                 cd && shc/100/303b-nodejs-stack.sh 2>&1 | tee -a 303b-nodejs_log$(date +"__%Y-%m-%d_%H.%M.%S").log  


                 

#  Purpose:  Install javascript stack(s)


http://askubuntu.com/questions/594656/how-to-install-the-latest-versions-of-nodejs-and-npm-for-ubuntu-14-04-lts


http://stackoverflow.com/questions/32426601/completly-uninstall-nodejs-npm-and-node-in-ubuntu-14-04
I would recommend installing node using Node Version Manager(NVM). That saved a lot of head ache for me. Because you can install nodejs and npm without sudo using nvm.


https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server



2019-05-19
	I used this.. https://tecadmin.net/install-latest-nodejs-npm-on-ubuntu/
		sudo apt-get install curl python-software-properties
		curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
		sudo apt-get install nodejs


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
 # npm uninstall -g sails 
 # npm uninstall -g ember-cli 
 # npm uninstall -g sane-cli 
# remove...
# sudo npm uninstall -g sails 
# sudo npm uninstall -g ember-cli 
# sudo npm uninstall -g sane-cli 
sudo apt-get -y update
sudo apt-get -y remove nodejs
sudo apt-get -y remove npm
sudo apt-get -y remove nvm
sudo apt-get -y purge nodejs npm
sudo apt-get -y autoremove

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#install nvm
# i didn't use nvm...
sudo apt-get -y install build-essential libssl-dev
#You should check the GitHub project page for the latest release of NVM, 
#   https://github.com/creationix/nvm/releases
#      edit v0.31.0 .....
# curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
#curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash


source ~/.profile
source ~/.bashrc
tail -n+10 ~/.bashrc |bash
exec bash



nvm --version
#http://www.liquidweb.com/kb/how-to-install-nvm-node-version-manager-for-node-js-on-ubuntu-14-04-lts/


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
date
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set +vx
echo 
echo 
echo 
echo 
echo 'next run -- exec bash;  303b-nodejs-stack.sh'
echo 
echo 
echo 