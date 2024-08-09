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

  
  usage:   cd ;   chmod +x shc/lxd/402lxclaunch.sh  ;  shc/lxd/402lxclaunch.sh 2>&1 | tee -a 402lxclaunch_log$(date +"__%Y-%m-%d_%H.%M.%S").log
 
  
  
 
_____________
  
ref..

lxc exec lx21 -- sudo --login --user ubuntu



BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow
set -vx
#

lxc launch ubuntu:x lx21

lxc list

# example..
	lxc file pull lx21/etc/hosts hosts.tmp

#

export e21=21env.sh
lxc exec lx21 --  mkdir -p /home/ubuntu/safe
lxc file push shc/a3/$e21 lx21/home/ubuntu/safe/$e21

export f21=403lxcprov.sh
# lxc file push /home/albe/shc/lxd/$f21 lx21/home/ubuntu/$f21
lxc exec lx21 -- rm /home/ubuntu/$f21
timeout1=2 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
lxc file push shc/lxd/$f21 lx21/home/ubuntu/$f21

# lxc exec lx21 -- sudo --login --user ubuntu -- sh /home/ubuntu/$f21
#
timeout1=2 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;

#
#
# Runs 403lxcprov.sh inside the container to provision it..
#
#
lxc exec lx21 -- sh /home/ubuntu/$f21


lxc list


# _____________



# the password is a


#     ssh ubuntu@10.99.1.208


#     curl  http://10.99.1.208


# _____________



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#exit 0  # bad idea. exit will prevent next script. return will give error if not returning from function. Use blockcomment.
# end of file comment this will not excecute.
#
set +vx
