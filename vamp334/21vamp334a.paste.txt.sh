#!/usr/bin/env bash

saynow()
{
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline21() {

echo tmp1
exit 999

: <<'BLOCKCOMMENT'

  Purpose:   
        setup kashmiri1 server for PLC data historian with ingition OPCUA and influxdb etc.
            2017-02-16_Thu_13.54-PM


BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#main...
saynow
#


# xubu1604 vbox on pmds-8lzwln1 pc [from osboxes.org]

# in osboxes.org user...

 sudo apt-get update ;  sudo apt-get install openssh-server wget 
 
 # can do this part from ssh, putty or mremoteNG - you can paste the rest with right click...
 
 sudo apt-get install git
 git clone https://github.com/dgleba/vamp206a.git shc
 chmod -R 775 shc/
 sudo groupadd www-data
 shc/bin1/nuser.sh albe
 
 # or
 mkdir -p bin
 chmod -R 775 bin/
 wget -N https://raw.githubusercontent.com/dgleba/vamp206a/master/bin1/nuser.sh
 sudo ./nuser.sh albe
 
  
 ifconfig
 sudo usermod -a -G sudo albe
 passwd
 sudo timedatecdl set-timezone EST

# no longer use osboxes.org user.


shd/vamp334/11albe.sh
shc/vamp334/21lamp.sh





