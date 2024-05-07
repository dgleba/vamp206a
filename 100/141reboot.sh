#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function stopvb(){
    su -c "VBoxManage controlvm redekv1 acpipowerbutton" -s /bin/bash albe
    while [ "`su -c 'VBoxManage list runningvms' -s /bin/bash albe`" != "" ]
    do
        echo waiting for VMs to shutdown
        sleep 4
    done
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline()
{
exit 999
# begin block comment =============================
: <<'END'
comment content
ls
END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...

# halt all vagrant machines...
#noworkyyy....  globalstatus no go...
sudo vagrant global-status | grep virtualbox | cut -c 1-9 | while read line; do echo $line; vagrant halt $line; done;
#read -t  122 -p "Hit ENTER or wait some seconds" ; echo ;

#stopvb
#read -t  123 -p "Hit ENTER or wait some seconds" ; echo ;

VBoxManage controlvm redekv1 acpipowerbutton

#https://forums.virtualbox.org/viewtopic.php?f=6&t=53684
VBoxManage setextradata "redekv1" GUI/DefaultCloseAction Shutdown

read -t  71 -p "Hit ENTER or wait some seconds" ; echo ;


#restart reboot the system...
sudo shutdown -r now

#
date
#

