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
  
  
  usage:  cd ; export pth=shc/lxd ; export fil=84lxd.sh ;  chmod +x $pth/$fil  ;  $pth/$fil  2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
  
  

BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

fil=shc/lxd ;fil=85lxd-init.sh ; 
cd ;   chmod +x $pth/$fil  ; source  $pth/$fil 2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log

fil=shc/lxd ;fil=402lxclaunch.sh ; 
cd ;   chmod +x $pth/$fil  ; source  $pth/$fil 2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log


# Check this file for ip address settings etc before running...
fil=shc/lxd ;fil=421lxcnet.sh ; 
#    cd ;   chmod +x $pth/$fil  ; source  $pth/$fil 2>&1 | tee -a $fil_log$(date +"__%Y-%m-%d_%H.%M.%S").log



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

