#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  

setup sound mixer with volume control..
http://askubuntu.com/questions/80384/where-are-the-lxde-sound-preferences

not sure this works..

2016-07-18_Mon_21.18-PM

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


to install

sudo apt-get install xfce4-mixer gstreamer0.10-alsa

This installs the following limited number of xfce packages -

exo-utils libgarcon-1-0 libgarcon-common libwnck-common libwnck22 libxres1
  xfce4-mixer xfce4-panel

to run

type xfce4-mixer in a lxterminal


#
date
#
