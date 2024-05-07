#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# docker install...

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list'

sudo apt-get update

sudo apt-get purge lxc-docker

sudo apt-cache policy docker-engine

sudo apt-get -y install linux-image-extra-$(uname -r)
sudo apt-get update

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

sudo apt-get -y install docker-engine

sudo apt-get install python-dev 

sudo usermod -aG docker $(whoami)

sudo service docker start
sudo service docker restart

sudo docker run hello-world

sudo pip install docker-compose




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2016-07-10_00.00.34

# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-14-04

#wget -qO- https://get.docker.com/ | sh

#sudo usermod -aG docker $(whoami)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
exit 999

# begin block comment =============================
: <<'END'

#get repo..
cd /var/www/html


END
# end block comment ===============================

}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#

