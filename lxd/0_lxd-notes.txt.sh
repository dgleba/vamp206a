
exit 9


2018-07-06_Fri_12.02-PM



My not-so-automated lxd setup scripts.


Follow  https://github.com/dgleba/vamp206a/blob/master/a3/11prep.sh



In..  https://github.com/dgleba/vamp206a/tree/master/lxd  folder...

Follow these in order...


85lxd-init.sh  -   usage:        cd ; export pth=shc/lxd ; export fil=85lxd-init.sh ;  chmod +x $pth/$fil  ;  $pth/$fil -cn lx21  2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;



logout and login again.



86lxd-init.sh  -   usage:       cd ; export pth=shc/lxd ; export fil=86lxd-init.sh ;  chmod +x $pth/$fil  ;  $pth/$fil -cn lx21  2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;


402lxclaunch.sh  -  usage:       cd ; export pth=shc/lxd ; export fil=402lxclaunch.sh ;  chmod +x $pth/$fil  ;  $pth/$fil -cn lx21  2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;


open  ...\lxd\427virtualboxnat.txt.sh with a text editor and read carefully - follow instructions in that file.


old. not needed...  - -  404lxdnet.sh   -  usage:   cd ;   chmod +x shc/lxd/404lxdnet.sh  ;  shc/lxd/404lxdnet.sh 2>&1 | tee -a 404lxdnet_log$(date +"__%Y-%m-%d_%H.%M.%S").log

  
  
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Reference....


# lxc stop lx21

# lxc delete lx21
# lxc delete lxredash
# lxc stop lxredash

  
  
lxc list
lxc network list
lxc network show lxdbr0
apt policy lxd lxd-client

#>81.  list

set vmname=ubu335c6
set vmname=ubu335c5b-cloned
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
%vboxm%  showvminfo %vmname% |grep -i nic

sudo shc/a3/32init.sh
  
  
http://10.4.10.118:3552/adminer/adminer.php
http://192.168.88.94:3552/adminer/adminer.php

http://192.168.88.94:3552/test2/phpinfo.php


http://10.4.10.118:3552/test2/



http://10.4.10.118:3552/test2/strap179

http://192.168.88.94:3552/actionlogin2/index.php?-action=homepage#

  
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2018-06-20[Jun-Wed]08-44AM

ubu
blandsand

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
