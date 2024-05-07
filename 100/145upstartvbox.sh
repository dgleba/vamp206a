#!/usr/bin/env bash
cd
set -x
source shc/21env.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function vboxst() {

#start vamp206d redekv1

ps -ef | grep virtual


#create upstart script for starting vbox...
sudo tee /etc/init/redekv1.conf <<EOF
description "start vbox redekv1"
author      "David Gleba"
#
start on runlevel [2345]
stop on runlevel [^2345]
#
console log
#
respawn
respawn limit 20 5
#
exec vboxmanage startvm redekv1
#
EOF

init-checkconf /etc/init/redekv1.conf

sudo service redekv1 start
ps -ef | grep virtual


}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
exit 999
ls
}



#main..
vboxst
#

