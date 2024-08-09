#
set -vx

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

export mysqlrootpassw="x"
export mysqluserpass="x"

#windows machine red5a settings.
export uredwe="dg"
export predwe="h"

#windows machine red5a settings.
export u3hz="dgleba"
export p3hz="h"

export pw1="a"
export pw2="a"
export pw3="a"
export pw4="a"

mkdir -p tmp01
tmp01="/home/$userv/tmp01"

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

