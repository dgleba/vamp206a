#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline()
{
exit 999

# begin block comment =============================
: <<'END'

#get repo..
cd /var/www/html

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2016-07-10_00.00.34

# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-14-04

#wget -qO- https://get.docker.com/ | sh

#sudo usermod -aG docker $(whoami)


END
# end block comment ===============================

}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# docker install...

sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates

sudo sh -c 'echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >>/etc/apt/sources.list.d/docker.list'

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-get update

sudo apt-get purge lxc-docker

sudo apt-cache policy docker-engine

#sudo apt-get -y install linux-image-extra-$(uname -r)
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual

sudo apt-get update

# ? sudo apt-get install linux-image-generic-lts-trusty

sudo apt-get -y install docker-engine

sudo apt-get -y install python-dev 

sudo usermod -aG docker $(whoami)

sudo service docker start
sudo service docker restart

sudo docker run hello-world

sudo pip install docker-compose


# https://github.com/docker/docker/issues/17645
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart


# https://docs.docker.com/machine/install-machine/
# curl -L https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-`uname -s`-`uname -m` > $HOME/tmp01/docker-machine && \
# sudo cp $HOME/tmp01/docker-machine /usr/local/bin/docker-machine && \
# sudo chmod +x /usr/local/bin/docker-machine


#
date
#

