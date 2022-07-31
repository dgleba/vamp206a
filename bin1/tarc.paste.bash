#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Purpose:  tar the current folder and give the archive a useful name..
#    this code can be pasted to terminal.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#cd ; 
#date ; set +vx  ; set -vx ; # echo off, then echo on
#
###### tar current folder..
base=$(basename $PWD);export HOSTNAME;
curfolder=${PWD##*/}
echo base=$base    hostname=$HOSTNAME  curfolder=$curfolder
cd ..
# get the current path and replace / with _
fnpath="${PWD////_}" ; echo $fnpath
dts=$(date +"__%Y.%m.%d_%H.%M.%S")
  #
  # notice the grep exclude list. Check to see nothing important is excluded.
  # 
  tfile=/tmp/tmp-file-find-for-tar_${USER}_2324.txt; 
  find $base -type f |  grep -Ev  \
     'x/|.tgz|.tar.gz|tmp/|.zip|inrm5/|cast04c/|.git/' > $tfile
  tar -vczf $base-$HOSTNAME$fnpath$dts.tgz -T $tfile
cd $base
date
set +vx
