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







hmm.

this uses virtualbox to run docker inside it.

why?








END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
date
#

#main...

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# flask docker
# https://github.com/realpython/orchestrating-docker
# https://realpython.com/blog/python/dockerizing-flask-with-compose-and-machine-from-localhost-to-the-cloud/

docker-machine --version
#docker-machine version 0.5.0 (04cfa58)
docker-compose --version
#docker-compose version: 1.5.0

#
# install docker-machine..
#
# https://github.com/docker/machine/releases/  get path to download here....
mkdir -p ~/tmp01
sudo curl -L https://github.com/docker/machine/releases/download/v0.5.6/docker-machine_linux-amd64 > ~/tmp01/docker-machine
sudo cp ~/tmp01/docker-machine /usr/local/bin  
sudo chmod +x /usr/local/bin/docker-machine  

mkdir -p /var/www/html/python
cd /var/www/html/python

git clone https://github.com/realpython/orchestrating-docker flask214a
cd flask214a

docker-machine create -d virtualbox dev;
# needs virtualbox......?




#
date
#


