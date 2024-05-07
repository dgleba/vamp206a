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
function blockcomment21() {
: <<'BLOCKCOMMENT'

  Purpose:   

  
  setup lxd and test
  

  Follow these in order...
  
    85lxd-init.sh  - paste these commands from command line.
    
    402lxclaunch.sh  -  cd ;   chmod +x shc/lxd/402lxclaunch.sh  ;  shc/lxd/402lxclaunch.sh 2>&1 | tee -a 402lxclaunch_log$(date +"__%Y-%m-%d_%H.%M.%S").log
 
    old...  not needed.. 404lxdnet.sh  - usage:   cd ;   chmod +x shc/lxd/404lxdnet.sh  ;  shc/lxd/404lxdnet.sh 2>&1 | tee -a 404lxdnet_log$(date +"__%Y-%m-%d_%H.%M.%S").log
 
  
  

BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function lxdinit() {

# purpose :  lxd init

 
  
  
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Works..     ssh and nginx


# 2018-06-18_Mon_11.16-AM

# use vbox vm vamp206a ubuntu 16.04 on csd dgleba pc

# ubu335c5b vamp206a
# container lxd lx21   
# ports
# 3501 ssh 22
# 3502 nginx 80

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# follow roughly..

# https://www.digitalocean.com/community/tutorials/how-to-set-up-and-use-lxd-on-ubuntu-16-04

# https://github.com/lxc/lxd/issues/2836

# https://askubuntu.com/questions/119393/how-to-save-rules-of-the-iptables

# ref..
# https://gauvain.pocentek.net/lxd-for-lxc-user.html

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# On host of the lxd..


apt policy lxd lxd-client


# just use lxd 3.0 - get rid of the old stuff...
#		 sudo apt -y install  lxd lxd-client

# if need be, get prompt for sudo password...
sudo ls
#
sudo apt -y remove --purge lxd lxd-client liblxc1 lxcfs

apt policy lxd lxd-client

set -vx

sudo snap install lxd

# _____________


tee <<EOF /tmp/initlxc.yml
config: {}
cluster: null
networks:
- config:
    ipv4.address: auto
    ipv6.address: none
  description: ""
  managed: true
  name: lxdbr0
  type: ""
storage_pools:
- config:
    size: 18GB
  description: ""
  name: default
  driver: zfs
profiles:
- config: {}
  description: ""
  devices:
    eth0:
      name: eth0
      nictype: bridged
      parent: lxdbr0
      type: nic
    root:
      path: /
      pool: default
      type: disk
  name: default
EOF



cat </tmp/initlxc.yml | sudo lxd init --preseed


lxc network list

# lxc network delete lxdbr1


# not working everytime.   -- sudo lxd init --auto

#sudo lxd init

# all default answers is OK.   ...   but - if you want, except last one. yes, show yaml...


# Last login: Tue Jun 19 15:20:34 2018 from 10.4.10.118
# albe@ubuntu1604a0311:~$ sudo lxd init
# [sudo] password for albe:
# Would you like to use LXD clustering? (yes/no) [default=no]:
# Do you want to configure a new storage pool? (yes/no) [default=yes]:
# Name of the new storage pool [default=default]:
# Name of the storage backend to use (btrfs, ceph, dir, lvm, zfs) [default=zfs]:
# Create a new ZFS pool? (yes/no) [default=yes]:
# Would you like to use an existing block device? (yes/no) [default=no]:
# Size in GB of the new loop device (1GB minimum) [default=18GB]:
# Would you like to connect to a MAAS server? (yes/no) [default=no]:
# Would you like to create a new local network bridge? (yes/no) [default=yes]:
# What should the new bridge be called? [default=lxdbr0]:
# What IPv4 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]:
# What IPv6 address should be used? (CIDR subnet notation, “auto” or “none”) [default=auto]:
# Would you like LXD to be available over the network? (yes/no) [default=no]:
# Would you like stale cached images to be updated automatically? (yes/no) [default=yes]
# Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: yes
# config: {}
# cluster: null
# networks:
# - config:
    # ipv4.address: auto
    # ipv6.address: auto
  # description: ""
  # managed: false
  # name: lxdbr0
  # type: ""
# storage_pools:
# - config:
    # size: 18GB
  # description: ""
  # name: default
  # driver: zfs
# profiles:
# - config: {}
  # description: ""
  # devices:
    # eth0:
      # name: eth0
      # nictype: bridged
      # parent: lxdbr0
      # type: nic
    # root:
      # path: /
      # pool: default
      # type: disk
  # name: default

# albe@ubuntu1604a0311:~$


# 2018-07-05_Thu_16.34-PM
# Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]: yes
# config: {}
# networks: []
# storage_pools: []
# profiles:
# - config: {}
  # description: ""
  # devices:
    # eth0:
      # name: eth0
      # nictype: bridged
      # parent: lxdbr0
      # type: nic
  # name: default
# cluster: null

# albe@ubuntu1604a0311:~$



# _____________



# Change private ip range to 10.99.1.x

# 2018-06-19_Tue_15.22-PM

# https://blog.ubuntu.com/2017/02/14/network-management-with-lxd-2-3


lxc network show lxdbr0
sudo lxc network set lxdbr0  ipv4.address 10.99.1.1/24
# lxc network set lxdbr0  ipv4.address 10.0.2.1/24
lxc network show lxdbr0


# sudo not needed..

# sudo lxc network show lxdbr0
# # sudo lxc network set lxdbr0  ipv4.address 10.99.1.1/24
# sudo lxc network set lxdbr0  ipv4.address 10.0.2.1/24
# sudo  lxc network show lxdbr0



# _____________


# Create a container..

lxc launch ubuntu:x ${ectname}

# observe the ip address.
lxc list



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


}


#main...
saynow
lxdinit
#
# timeout1=98765 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
# return 9

set +vx
