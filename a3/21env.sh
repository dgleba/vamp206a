echo ~----------~----------Startingb $HOSTNAME, pwd: `pwd`, "${BASH_SOURCE[0]}" $(date +" %Y-%m-%d_%H.%M.%S")
echo "${BASH_SOURCE[@]}"  # echo full bashsource array

date ; set +vx  ; set -vx ; # echo off, then echo on
set +vx

#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# edit these variables to match your system...
#
export HOSTNAME

export userv="albe"
#this stores root not the regular user.
#userv=$USER

#user for automated emails
export user2="pmdsu"

#hostname from unattended iso...
export orig_hostname="vamp206b"
# new hostname..
export default_hostname="pmdsdata99876"
export default_domain="local"

export mysqlrootpassw="a"
export mysqluserpass="a"

#windows machine red5a settings.
export uredwe="dg"
export predwe="h"

#windows machine red5a settings.
export u3hz="dgleba"
export p3hz="h"


export pw1="a"
export pw2="a"
#
# for basic auth..
export pw3="a"
#
export pw4="a"


mkdir -p tmp01
export tmp01="/home/$userv/tmp01"

mkdir -p  /home/$userv/_this-vamp206b

# determine ubuntu version
#export ubuntu_versionall=$(lsb_release -sa)
export ubuntu_versiona=$(lsb_release -sc)
export ubuntu_versionb="$(lsb_release -sd)"

#export -p


function offline() {
exit 9
alb@vamp206b:~$ #sudo echo $HOME
/home/alb
alb@vamp206b:~$ 
}

