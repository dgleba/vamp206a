#!/usr/bin/env bash
date ; set +vx  ; set -vx ; # echo off, then echo on
set +vx
echo ~----------~----------Startinga [dirname $0 basename $0] `dirname "$0"`/`basename "$0"` 
# echo ~----------~----------Startingc [readlink ] `$(readlink -f $0)` 
echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, dlr0: "$0", bashsource0: "${BASH_SOURCE[0]}", $(date +"%Y-%m-%d_%H.%M.%S")
# https://stackoverflow.com/questions/8911724/how-to-find-out-name-of-script-called-sourced-by-another-script-in-bash
#echo "from file.... ${BASH_SOURCE[0]}"
echo bashsource@0: "${BASH_SOURCE[@]}"  # echo full bashsource array

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function blockcomment21 {
: <<'BLOCKCOMMENT'

  Purpose:   

  function abc {
  }

  or 
  abc() {
  }
  
BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Functions...



function saynow {

date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
# I think with lib.trap.sh the read prompt doesn't show. so..   timeout1=111 ; echo "Press ENTER or wait ${timeout1} seconds...." ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
  
}

fuction backup1 {

# create file hello, backup the original file once, and copy it with timestamp.
# An example of how to backup a file before editing it with a script.
mkdir -p ~/tmp01
file1="$HOME/tmp01/hello"
echo "hello" >$file1 ; echo "foo bar">>$file1
# backup original file once..
if [ ! -f $file1.orig ] ; then  cp -a $file1 $file1.orig ; fi  # do you need sudo cp?
#back it up with a unique name using a timestamp..
 cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt     # do you need sudo cp?
 cp $file1 $file1.bak.txt                                   # do you need sudo cp?
# add line1's after line matching pattern1
pattern1='^hello'
line1=' \ \ #added line 1\n \ #added line 2 = ":8071" '
 sed -i.$(date +"_%Y%m%d_%H%M%S").sedbak.txt "/$pattern1/a $line1" $file1   # do you need sudo sed?
# restore to orig.. sudo cp $file1.orig $file1
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# get commmand line arguments / parameters


export CLEAR='\033[0m'
export RED='\033[0;31m'
  echo -e "${CLEAR}"

usage() {
  if [ -n "$1" ]; then
    echo -e "${RED}ERROR $1\n";
  fi
  echo "Usage: $0 [-t install-type] "
  echo "  -t, --install-type   Type of install, regularmysqlserver, columnstore, or custom1"
  echo ""
  echo "Example: $0 -t regularmysqlserver "
  echo -e "${CLEAR}"
  exit 1
}

# parse params
while [[ "$#" > 0 ]]; do case $1 in
  -t|--install-type) tname="$2"; shift;shift;;
  *) usage "Unknown parameter passed: $1"; shift; shift;;
esac; done

# verify params
if [ -z "$ctname" ]; then usage "Container name not supplied"; fi;

export etname=${tname}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow
backup1
#



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# exit 0  # bad idea. exit will prevent next script. return will give error if not returning from function. Use blockcomment for multiline comments.
