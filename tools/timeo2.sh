#!/usr/bin/env bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function blockcomment21() {
: <<'BLOCKCOMMENT'

  Purpose:  example of a sleep command that can be shortened by keypress.


BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


#
date ; set +vx
#

# set timeout seconds, display message, if no input given then return true so error is not raised, echo a new line after to prevent two items on one line.
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;

#
date ; set +vx
#
