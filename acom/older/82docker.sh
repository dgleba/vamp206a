#!/usr/bin/env bash
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
set +vx
echo ~----------~----------Startinga `dirname "$0"`/`basename "$0"`
# echo ~----------~----------Startingc  `$(readlink -f $0)` 
echo ~----------~----------Startingd $HOSTNAME, pwd: `pwd`, "$0", "${BASH_SOURCE[0]}", $(date +"%Y-%m-%d_%H.%M.%S")
# https://stackoverflow.com/questions/8911724/how-to-find-out-name-of-script-called-sourced-by-another-script-in-bash
echo "from file.... ${BASH_SOURCE[0]}"
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

saynow()
{
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
# I think with lib.trap.sh the read prompt doesn't show. so..   timeout1=111 ; echo "Press ENTER or wait ${timeout1} seconds...." ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
  
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 2019-12-12

# Latest install articles..

# Use convenience-script

# https://docs.docker.com/install/linux/docker-ce/ubuntu/
  # Install using the convenience script

# Compose

# https://docs.docker.com/compose/install/




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function blockcomment21() {
: <<'BLOCKCOMMENT'

  Purpose:   install docker on ubuntu-16-04-lts
  


_____________

for
  ubu 14.04 - 2018-06-25

# works..
    apt update
    apt-get remove docker docker-engine docker.io
   curl -fsSL get.docker.com -o get-docker.sh
    sh get-docker.sh
  
# albe@pmdsdata4:~$ docker version
# Client:
 # Version:      18.05.0-ce

 apt-get -y remove docker-compose
# then install the newest version on the release page at GitHub with
 curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
 chmod +x /usr/bin/docker-compose
docker-compose -v

 
BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow
#



# https://askubuntu.com/questions/938700/how-do-i-install-docker-on-ubuntu-16-04-lts

# Set up the docker repository

#  apt-get update
#  apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
#  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#  apt-get update

apt-cache policy docker-ce


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-convenience-script

sudo snap remove docker


sudo  apt-get update
sudo  apt-get -y remove docker docker-engine docker.io  containerd runc docker-ce docker-ce-cli containerd.io

# Uninstall the Docker CE package:
sudo  apt-get -y purge docker-ce

sleep 6
  
curl -fsSL get.docker.com -o get-docker.sh
sudo  sh get-docker.sh
  
# alb@pmdsdata4:~$ docker version
# Client:
# Version:      18.05.0-ce


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# google :  docker-compose install


# https://docs.docker.com/compose/install/


sudo  apt-get -y remove docker-compose
sudo  rm  /usr/bin/docker-compose
sudo  rm  /usr/local/bin/docker-compose

# then install the newest version on the release page at GitHub with
# sudo curl -L https://github.com/docker/compose/releases/download/1.29.4/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
#
# Docker Compose
# noworky...  sudo wget --output-document=/usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/$(wget --quiet --output-document=- https://api.github.com/repos/docker/compose/releases/latest | grep --perl-regexp --only-matching '"tag_name": "\K.*?(?=")')/run.sh"
# sudo wget --output-document=/etc/bash_completion.d/docker-compose "https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose"
# printf '\nDocker Compose installed. Please check the version...\n\n'


# # Docker Compose noworky..
# compose_release() {
  # curl --silent "https://api.github.com/repos/docker/compose/releases/latest" |   grep -Po '"tag_name": "\K.*?(?=")'| sed 's/[^0-9.]//g'
 # #curl          "https://api.github.com/repos/docker/compose/releases/latest" |   grep -Po '"tag_name": "\K.*?(?=")'
# }
# compose_release
# if ! [ -x "$(command -v docker-compose)" ]; then
  # sudo curl -L https://github.com/docker/compose/releases/download/$(compose_release)/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose 
  # sudo chmod +x /usr/bin/docker-compose
# fi


#works..
# pre2022-11-24 sudo curl -L https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose

#  i did this...  sudo mv /usr/bin/docker-compose /usr/bin/docker-compose001
sudo curl -SL https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-linux-x86_64 -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
ls -la /usr/bin/docker-compose*

docker-compose -v



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#  apt-get -y install docker-ce
#  apt-get -y install docker.io


# https://docs.docker.com/install/linux/docker-ce/ubuntu/#os-requirements


#  apt-get -y remove docker docker-engine docker.io

# apt-cache madison docker-ce
# dockerv='18.03.0~ce-0~ubuntu'
#  apt-get -y install docker-ce=$dockerv


#  systemctl status docker
# docker -v
# docker version


#  apt -y install docker-compose
# docker

#  docker run hello-world



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# run docker without .. 
sudo  usermod -aG docker $(whoami)
sudo  usermod -aG docker albe
sudo  usermod -aG docker ubuntu
# su - ${USER}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#no..
#  apt-get upgrade docker-compose
#  apt-get upgrade 


#
# upgrade docker compose
#
#  apt-get -y remove docker-compose
# # then install the newest version on the release page at GitHub with
#  curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
#  chmod +x /usr/bin/docker-compose
# docker-compose -v
#
# ref..
# https://stackoverflow.com/questions/49839028/how-to-upgrade-docker-compose-to-latest-version
# https://github.com/docker/compose/releases
#  curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# docker-compose -v
# curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


docker version
docker-compose version

echo 
echo ' *******  You will have to logout and back in again to use it without root.'
echo 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
