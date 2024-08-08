#!/usr/bin/env bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline21() {
echo tmp1; exit 999
: <<'BLOCKCOMMENT'

  Purpose:   install npm, angular-cli 2017-01-09_Mon_19.58-PM


BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

saynow()
{
# works.
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
}

#main...
saynow

#nodejs was installed here..
#C:\n\Dropbox\csd\serve\vboxyard\vamp206a\rails\railsinstall-1root.sh


# update to nodejs 4
# curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
# curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -

# To install the LTS release, use this PPA
# curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -

curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -

 sudo apt-get install -y nodejs

sudo apt-get -y install npm
sudo npm install npm@latest -g


#sudo npm install -g angular-cli



----------------------------------------------------
Title:  .
-----------------------2018-10-12[Oct-Fri]09-07AM

# Downgrade.

# On the Android/Linux stacks
# Same thing, first uninstall the current version then install the new one. 
# Using the official one-liners for Debian/Ubuntu 
# (https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions 172):



# #!/bin/bash
# set -ex

# # remove previous version
# sudo apt-get remove -y nodejs

# # install older / other version
# curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
# sudo apt-get install -y nodejs


----------------------------------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2017-01-09[Jan-Mon]20-44PM

npm ERR! argv "/usr/bin/nodejs" "/usr/bin/npm" "install"
npm ERR! node v4.7.2
npm ERR! npm  v4.0.5
npm ERR! path ../acorn/bin/acorn
npm ERR! code EROFS
npm ERR! errno -30
npm ERR! syscall symlink

npm ERR! rofs EROFS: read-only file system, symlink '../acorn/bin/acorn' -> '/home/albe/share203/home_library/home-library/node_modules/.bin/acorn'
npm ERR! rofs This is most likely not a problem with npm itself
npm ERR! rofs and is related to the file system being read-only.
npm ERR! rofs 
npm ERR! rofs Often virtualized file systems, or other file systems
npm ERR! rofs that don't support symlinks, give this error.

npm ERR! Please include the following file with any support request:
npm ERR!     /home/albe/share203/home_library/home-library/npm-debug.log

_____________ 


npm ERR! code EROFS errno -30 syscall symlink

npm ERR! rofs EROFS: read-only file system, symlink '../acorn/bin/acorn' -> .. node_modules/.bin/acorn'
npm ERR! rofs This is most likely not a problem with npm itself
npm ERR! rofs and is related to the file system being read-only.



https://github.com/npm/npm/issues/7308

echo "alias npm='npm --no-bin-links'" >> /home/vagrant/.bashrc

npm install -–no-bin-links gulp

_____________ 


http://stackoverflow.com/questions/34974535/install-latest-nodejs-version-in-ubuntu-14-04


curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs


npm WARN deprecated minimatch@2.0.10: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue

npm update -g minimatch@3.0.2


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2017-01-09[Jan-Mon]21-00PM

mac

brew install node
npm install -g angular-cli



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#

