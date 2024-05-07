:make vbox larger...  [win]

:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

: this is a windows batch file.
: edit paths and names throughout this file...

:set env variables... Edit these to your liking.
set vmname=vamp206b
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"

:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd "C:\Users\dgleba\VirtualBox VMs\vamp206b"
cd
timeout 9

:%vboxm%  modifyhd "C:\Users\dgleba\VirtualBox VMs\vamp206b\vamp206b_151101_214521-disk1.vmdk"  --resize 13920

%vboxm%  clonehd  "C:\Users\dgleba\VirtualBox VMs\vamp206b\vamp206b_151101_214521-disk1.vmdk"  u:\vbox\vamp206-d1.vdi --format VDI
%vboxm%  modifyhd "u:\vbox\vamp206-d1.vdi"  --resize 14920

pause
