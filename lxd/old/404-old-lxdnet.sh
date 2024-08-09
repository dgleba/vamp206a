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

  
    usage:   cd ; chmod +x shc/lxd/404lxdnet.sh ; shc/lxd/404lxdnet.sh 2>&1 | tee -a 404lxdnet_log$(date +"__%Y-%m-%d_%H.%M.%S").log
 
  
  set networking to container.
  
  Ip addresses must be edited below..
  
  
  
ref..
  
lxc exec lx21 -- sudo --login --user ubuntu



BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow
#
set -vx



export PUBLIC_IP=192.168.88.55 ;
#
export CONTAINER_IP=10.99.1.208;
#
export PubPORT=3502; 
export CPORT=80;
#
# export 
#
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT

#

export PubPORT=3501; 
export CPORT=22;
#
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT


# _____________


 sudo iptables -t nat -L PREROUTING


# _____________

 
# https://askubuntu.com/questions/119393/how-to-save-rules-of-the-iptables

sudo apt -y install iptables-persistent

# The installation as described above works without a problem, but some commands for saving and reloading do not seem to work with a 16.04 server. The following commands work with that version:

sudo netfilter-persistent save
sudo netfilter-persistent reload



# _____________


# the password is a

#    ssh -p 3501 ubuntu@10.4.10.226

#    ssh -p 3501 ubuntu@192.168.88.55


#    curl  'http://10.4.10.107:3502'

#    curl  http://192.168.88.55:3502


# _____________


set +vx

