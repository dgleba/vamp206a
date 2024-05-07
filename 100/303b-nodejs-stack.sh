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



nvm --version
#http://www.liquidweb.com/kb/how-to-install-nvm-node-version-manager-for-node-js-on-ubuntu-14-04-lts/


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#worked...


#http://sailsjs.org/get-started

# sudo apt-get -y install python-software-properties python g++ make

# curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -





#https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04
# nvm install 8.9.0
nvm install 14

# nvm use 8.9.0
nvm use 14

nvm ls


# nosudo

# albe@pmdsdata7:/srv/file/listor$ npm config get prefix


# /home/albe/.nvm/versions/node/v10.15.0
# ┌────────────────────────────────────────────────────────┐
# │                npm update check failed                 │
# │          Try running with sudo or get access           │
# │          to the local update config store via          │
# │ sudo chown -R $USER:$(id -gn $USER) /home/albe/.config │
# └────────────────────────────────────────────────────────┘
# albe@pmdsdata7:/srv/file/listor$





mkdir ~/.npm-packages
npm config set prefix ~/.npm-packages
sudo chown -R $USER:$(id -gn $USER)  /home/albe/.npm-packages

sudo chown -R $USER:$(id -gn $USER)  /home/albe/.npm

nvm use --delete-prefix v10.15.1

#
# albe@ubu381a80705:~$ nvm install 10
# v10.15.1 is already installed.
# nvm is not compatible with the npm config "prefix" option: currently set to "/home/albe/.npm-packages"
# Run `nvm use --delete-prefix v10.15.1` to unset it.




node -v
nvm --version
npm -v
npx -v
sails -v

# test - install something..
cd 
mkdir 0
cd 0
npm install -g marked --save

# Update it..
npm install npm -g




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
date
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


