


Can't do this..


have to logout out after lxd install.


error...


++ sudo snap install lxd

E[7mnsure prerequisites for "lxd" are available               [0m                                                                                                                  
[0m[?12;25h[Klxd 3.2 from 'canonical' installed

++ tee /tmp/initlxc.yml
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
++ sudo lxd init --preseed
++ cat
Error: Failed to connect to local LXD: Get http://unix.socket/1.0: dial unix /var/snap/lxd/common/lxd/unix.socket: connect: no such file or directory
++ lxc network list















































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
function_blockcomment21() {
: <<'BLOCKCOMMENT'

  Purpose:   

  
  setup lxd and test
  
  
  usage:  cd ; export pth=shc/lxd ; export fil=84lxd.sh ;  chmod +x $pth/$fil  ;  $pth/$fil -cn lx21  2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
  
  

BLOCKCOMMENT
}
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
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

pth=shc/lxd ;fil=85lxd-init.sh ; 
cd ;   chmod +x $pth/$fil  ; source  $pth/$fil 2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log

pth=shc/lxd ;fil=402lxclaunch.sh ; 
cd ;   chmod +x $pth/$fil  ; source  $pth/$fil 2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log


# Check this file for ip address settings etc before running...
fil=shc/lxd ;fil=421lxcnet.sh ; 
#    cd ;   chmod +x $pth/$fil  ; source  $pth/$fil 2>&1 | tee -a $fil_log$(date +"__%Y-%m-%d_%H.%M.%S").log



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

