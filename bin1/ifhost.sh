#!/usr/bin/env bash

hostname -s

if [[ $(hostname -s) = pmdsdata3* ]]; then
    ls
    echo this matched test
else
    echo This did not match test..
fi

set -vx

# If hostname is pmdsdata3 then don't import data...
# > /dev/null
# http://stackoverflow.com/questions/1728683/case-insensitive-comparison-of-strings-in-shell-script
match1='V206X' 
if (hostname -s | grep -i "$match1" ) ; then
  echo "hostname matched test for $match1, so dont import data."
else
  echo 'This is not pmdsdata3, so we will import the data...'	
	echo 'import stuff.........'
fi


timeout1=4 ; read -t $timeout1 -p "Press ENTER or wait $time1 seconds" ; echo ;
read -t 99 -p "Press ENTER or wait some seconds" ; echo ;
