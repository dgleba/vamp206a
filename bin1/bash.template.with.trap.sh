#!/usr/bin/env bash

function abort()
{
    # set -e will exit on first error. so set -vxe..
    # http://stackoverflow.com/questions/2870992/automatic-exit-from-bash-shell-script-on-error
    echo >&2 '
    ***************
    *** ABORTED ***
    ***************
    '
    # date ; 
    dts=$(date +"%Y-%m-%d_%H.%M.%S"); 
    echo "started at: ${dts1} "
    echo "An error occurred. Exiting at ... ${dts}" >&2
    exit 1
}

# comment out the next two lines to disable the abort on error. [ trap and set -e]..
# commented out it will not stop - just continue after and error and go to completion.
# You will have to find the error way back somewhere in the terminal. You may want that to happen. You have a choice.
trap 'abort' 0
set -e
echo
echo
echo Press ctrl-c now if you want to stop and not run this.
echo
date
timeout1=20 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;


dts1=$(date +"%Y-%m-%d_%H.%M.%S");
echo "starting at:  ${dts1}"

# Add your script below.... If an error occurs, the abort() function will be called.
#----------------------------------------------------------
# ===> Your script goes here.........................









# a bad command will cause abort
badcommand
ls
pwd









### finish up.. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set +vx
pwd
# echo  '----------------------------------------> !!! Reached end of file !!!'
echo  .
set +vx
#

# Done!....................
trap : 0
#date
echo   "started at:  $dts1" 
dts=$(date +"%Y-%m-%d_%H.%M.%S"); echo " ending at:  ${dts}"
echo >&2 '

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!   DONE    !!!**
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

'
#
