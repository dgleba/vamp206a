#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'


tarcap = tarc ap folder. tars current folder without using parent folder.
This avoids the need to be able to write to the parent folder.

Usage:   cd /ap; tarcap

#  Purpose:  tar the current folder and give the archive a useful name..

Used for the /ap folder.
excludes some files to keep the output smaller. 
Could work for other folders if you review the excluded items.



#  VERSION info
	
	v26 - 2021-06-30 -- find files grep exclude then tar


chmod +x ~/bin/tarc4

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#cd ; 
date ; set +vx  ; set -vx ; # echo off, then echo on
#


###### tar current folder..
base=$(basename $PWD);export HOSTNAME;
curfolder=${PWD##*/}
echo base=$base    hostname=$HOSTNAME  curfolder=$curfolder

dts=$(date +"__%Y.%m.%d_%H.%M.%S")


tar1() {
 
    # get the current path and replace / with _
    fnpath="${PWD////_}" ; echo $fnpath

    tarf() {
      #
      # notice the grep exclude list. Check to see nothing important is excluded.
      # 
      tfile=./tmp-file-find-for-tar_${USER}_2324.txt; 
      find $base -type f |  grep -Ev  \
        'data/|sysdata/|public/assets/|/x/|.tgz|log/|tmp/|certs/|node_modules|datasys|zip' > $tfile
      # Careful, the above excludes any data string|folder..
      # cat $tfile
      tar -czf $base-$HOSTNAME$fnpath$dts.tgz -T $tfile
    }

    tarf-one() {
      tfile=/tmp/tmpfilefindtar23234.txt; 
      find . -type f |  grep -Ev  \
        'data/|sysdata/|datasys/|public/assets/|x/|.tgz|node_modules/|zip/|static/|log/|tmp/' > $tfile
      tar -czf $HOSTNAME$fnpath$dts.tgz -T $tfile
    }

    # run one of the above..

    tarf-one
    

}



tar1

#
date
#
set +vx

