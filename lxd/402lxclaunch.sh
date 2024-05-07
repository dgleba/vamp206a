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


  Purpose:   provision container 

  
  usage:   cd ;   chmod +x shc/lxd/402lxclaunch.sh  ;  shc/lxd/402lxclaunch.sh 2>&1 | tee -a 402lxclaunch_log$(date +"__%Y-%m-%d_%H.%M.%S").log
    
 
 
_____________
  
ref..

lxc exec lx21 -- sudo --login --user ubuntu



BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

export CLEAR2='\033[0m\033[1;37m'
export CLEAR='\033[0m'
export RED='\033[0;31m'
  echo -e "${CLEAR}"

usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}ERROR $1\n";
  fi
  echo "Usage: $0 [-cn container-name] "
  echo "  -cn, --container-name   Name of the new Container"
  echo ""
  echo "Example: $0 -cn lx21 "
  echo -e "${CLEAR}"
  exit 1
}

# parse params
while [[ "$#" > 0 ]]; do case $1 in
  -cn|--container-name) ctname="$2"; shift;shift;;
  *) usage "Unknown parameter passed: $1"; shift; shift;;
esac; done

# verify params
if [ -z "$ctname" ]; then usage "Container name not supplied"; fi;

export ectname=${ctname}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow
set -vx
#

#test ctname=t22
export ectname=${ctname}
lxc init ubuntu:x ${ectname}
lxc stop ${ectname}
lxc network attach lxdbr0 ${ectname} eth0 eth0
lxc config device set ${ectname} eth0 ipv4.address 10.99.1.99
lxc start ${ectname}
lxc list


timeout1=4 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
lxc list

# example..
	lxc file pull ${ctname}/etc/hosts hosts.tmp

#

export e21=21env.sh
lxc exec ${ctname} --  mkdir -p /home/ubuntu/safe
lxc file push shc/a3/$e21 ${ctname}/home/ubuntu/safe/$e21

export f21=403lxcprov.sh
# lxc file push /home/albe/shc/lxd/$f21 ${ctname}/home/ubuntu/$f21
lxc exec ${ctname} -- rm /home/ubuntu/$f21
timeout1=2 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
lxc file push shc/lxd/$f21 ${ctname}/home/ubuntu/$f21

# lxc exec ${ctname} -- sudo --login --user ubuntu -- sh /home/ubuntu/$f21
#
timeout1=2 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;

#
#
# Runs 403lxcprov.sh inside the container to provision it..
#
#
lxc exec ${ctname} -- sh /home/ubuntu/$f21  2>&1 | tee -a ${f21}_log$(date +"__%Y-%m-%d_%H.%M.%S").log
    


timeout1=4 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
lxc list
timeout1=4 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
lxc stop ${ctname} 
timeout1=4 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
lxc start ${ctname} 
timeout1=4 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
lxc list



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sudo iptables -t nat -L PREROUTING --line-numbers

 
#    *****   Edit the IP addresses below...   *****  
# 
# export PUBLIC_IP=192.168.88.46;    # if on hyperv or baremetal, use the hosts ip address as the public ip and forward to the container.
export   PUBLIC_IP=10.0.2.15;        # use the private ip address of the nat vbox vm if using virtualbox..
#
export CONTAINER_IP=10.99.1.99;
#
export PubPORT=3552; 
export CPORT=80;
#
# export 
#
sudo iptables -t nat -L PREROUTING --line-numbers
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT
#
export PubPORT=3551; 
export CPORT=22;
#
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT




lxc list --fast
lxc list 
sudo iptables -t nat -L PREROUTING --line-numbers



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



# the password is a


#     ssh ubuntu@10.99.1.208


#     curl  http://10.99.1.208


#    ssh -p 3501 ubuntu@10.4.10.175

#    ssh -p 3501 ubuntu@192.168.88.46


#    curl  'http://10.4.10.175:3502'

#    curl  http://192.168.88.46:3502



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
set +vx
