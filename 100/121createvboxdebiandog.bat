:create vbox 

:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

: this is a windows batch file.
: edit paths and names throughout this file...

:set env variables... Edit these to your liking.
set vmname=debdog1
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"
set mediu="C:\var\varvamp\files\DebianDog-Jessie-openbox_xfce-2015-09-02-PAE.iso"

:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:create the vm
%vboxm% createvm --name %vmname% --ostype Ubuntu_64 --register
%vboxm% modifyvm %vmname% --memory 640 --cpus 1  --acpi on   --clipboard bidirectional


::nic...
:: ref:  http://kappataumu.com/articles/creating-an-Ubuntu-VM-with-packer.html
:: get names of physical interfaces
%vboxm% list bridgedifs
SET _prefix=%COMPUTERNAME:~0,5% 
IF %_prefix%==REDWE  %vboxm% modifyvm %vmname%  --nic1 bridged --bridgeadapter1 "Intel(R) Dual Band Wireless-AC 3160 #2" --nictype1 virtio
SET _prefix=%COMPUTERNAME:~0,8% 
IF %_prefix%==PMDS-3HZ  %vboxm% modifyvm %vmname%  --nic1 bridged --nictype1 virtio --bridgeadapter1 "Intel(R) Ethernet Connection I217-LM"
: set mac addr... This is problematic if two vm's ge the same address... be careful...
%vboxm% modifyvm %vmname% --macaddress1=%macaddvamp%


:
:shared folders...
:
:%vboxm% sharedfolder add %vmname% --name %vmname% --hostpath c:/var/sharexx/ --automount
%vboxm% sharedfolder remove %vmname% --name share203 
mkdir c:\var\share203
%vboxm% sharedfolder add %vmname% --name share203 --hostpath c:/var/share203/ 
: for /var/www/html ...
%vboxm% sharedfolder add %vmname% --name html --hostpath c:/p2/vamp/htdocs 

cd \temp
mkdir "C:\Users\%USERNAME%\VirtualBox VMs\%vmname%\"

%vboxm% createhd --filename "C:\Users\%USERNAME%\VirtualBox VMs\%vmname%\%vmname%.vdi" --size 31240 --format VDI
%vboxm%  storagectl %vmname% --name storage --add sata  --controller IntelAHCI 
%vboxm% storageattach %vmname% --storagectl storage --port 1 --medium "C:\Users\%USERNAME%\VirtualBox VMs\%vmname%\%vmname%.vdi" --type hdd
%vboxm% storageattach %vmname% --storagectl storage --port 2 --medium %mediu% --type dvddrive
%vboxm% modifyvm %vmname% --boot1 dvd

%vboxm% startvm %vmname% 

pause
