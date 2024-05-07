:create vbox empty...  [win]

:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

: this is a windows batch file.
: edit paths and names throughout this file...

:set env variables... Edit these to your liking.
set vmname=vamp206b
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"

:others to edit...
:IF %_prefix%==REDWE  %vboxm% modifyvm %vmname%  --nic1 bridged --bridgeadapter1 "Intel(R) Dual Band Wireless-AC 3160 #2" --nictype1 virtio
:C:\var\varvamp\files\ubuntu-14.04.3-server-amd64-unattended.iso
:shared folders...


:: to get random mac addr,  coment these out...
:this will assign this ip address at csd..
:set macaddvamp=08002795526A
:
::if redwe, then ...
SET _prefix=%COMPUTERNAME:~0,5% 
IF %_prefix%==REDWE  set macaddvamp=08002795527B
timeout 3
:
:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


@ECHO OFF
echo Waiting for - Looking for - ubuntu-14.04.3-server-amd64-unattended.iso file...
SET LookForFile="C:\var\varvamp\files\ubuntu-14.04.3-server-amd64-unattended.iso"
:CheckForFile
IF EXIST %LookForFile% GOTO FoundIt
REM If we get here, the file is not found.
REM Wait 10 seconds and then recheck.
REM If no delay is needed, comment/remove the timeout line.
:TIMEOUT /T 10 >nul
TIMEOUT /T 10 
GOTO CheckForFile
:FoundIt
ECHO Found: %LookForFile%
Echo on


:Prepare date and temp folders
set ymd=%date:~12,2%%date:~4,2%%date:~7,2%&set dhms=%date:~12,2%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
::ref
:http://zaufi.github.io/administration/2012/08/31/vbox-setup-new-vm/
:http://www.trimentation.com/wp/?p=100
:
:not used...
:set vboxm1="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
: for git bash,  noworky... 'c/Program Files/Oracle/VirtualBox/VBoxManage'

:create the vm
%vboxm% createvm --name %vmname% --ostype Ubuntu_64 --register


::..nic problem..
:%vboxm% modifyvm %vmname% --memory 768 --cpus 1  --acpi on  --nic1 bridged --bridgeadapter1 wlan0 --vrde on --vrdeport 5555 --clipboard bidirectional
:Could not start the machine vamp203b because the following physical network interfaces were not found:
:wlan0 (adapter 1)
:You can either change the machine's network settings or stop the machine.
: noworky.. %vboxm% modifyvm %vmname%  --nic1 bridged --bridgeadapter1 eth0 
:%vboxm% modifyvm %vmname%  --vrde on --vrdeport 5555 
::no...
:%vboxm% modifyvm %vmname%   --nic1 bridged --bridgeadapter3 wlan0

%vboxm% modifyvm %vmname% --memory 768 --cpus 2  --acpi on   --clipboard bidirectional


::nic...
:: ref:  http://kappataumu.com/articles/creating-an-Ubuntu-VM-with-packer.html
:: get names of physical interfaces
%vboxm% list bridgedifs
: mine - on toshiba s55t --   Intel(R) Dual Band Wireless-AC 3160 #2
: eg:  vboxmanage modifyvm your-vm-name-here --nic1 bridged --bridgeadapter1 "Intel(R) Ethernet Connection I217-V"
:worked..

SET _prefix=%COMPUTERNAME:~0,5% 
IF %_prefix%==REDWE  %vboxm% modifyvm %vmname%  --nic1 bridged --bridgeadapter1 "Intel(R) Dual Band Wireless-AC 3160 #2" --nictype1 virtio

SET _prefix=%COMPUTERNAME:~0,8% 
IF %_prefix%==PMDS-3HZ  %vboxm% modifyvm %vmname%  --nic1 bridged --nictype1 virtio --bridgeadapter1 "Intel(R) Ethernet Connection I217-LM"

: I could not run the vm inside the hyperv host....
SET _prefix=%COMPUTERNAME:~0,8% 
IF %_prefix%==PMDSDATA  %vboxm% modifyvm %vmname%  --nic1 bridged --nictype1 virtio --bridgeadapter1 "Microsoft Hyper-V Network Adapter"

: set mac addr... This is problematic if two vm's ge the same address... be careful...
:%vboxm% modifyvm %vmname% --macaddress1=%macaddvamp%
%vboxm% modifyvm %vmname% 



REM  set vmname=ubu335c5
REM  set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
REM  NAT...
REM  %vboxm%  modifyvm %vmname% --nic1 nat
REM  %vboxm%  modifyvm %vmname% --natpf1 "guestssh,tcp,,3541,,22"
REM  %vboxm%  modifyvm %vmname% --natpf1 "guest80,tcp,,3542,,80"



:
:shared folders...
:
:%vboxm% sharedfolder add %vmname% --name %vmname% --hostpath c:/var/sharexx/ --automount
%vboxm% sharedfolder remove %vmname% --name share203 
mkdir c:\var\share203
%vboxm% sharedfolder add %vmname% --name share203 --hostpath c:/var/share203/ 
: for /var/www/html ...
%vboxm% sharedfolder add %vmname% --name html --hostpath c:/p2/vamp/htdocs 


::to be used after guest additions are added to the vm. use in vm later.
:mkdir ~/share203
:sudo mount -t vboxsf -o uid=$UID,gid=$(id -g) share203 ~/share203
:sudo mount -t vboxsf  share203 ~/share203
:mkdir /var/www/html
:sudo mount -t vboxsf  html /var/www/html


cd \temp
mkdir "C:\Users\%USERNAME%\VirtualBox VMs\%vmname%\"

%vboxm% createhd --filename "C:\Users\%USERNAME%\VirtualBox VMs\%vmname%\%vmname%.vdi" --size 43240 --format VDI

%vboxm%  storagectl %vmname% --name storage --add sata  --controller IntelAHCI 
:# %vboxm%  storagectl %vmname% --name storage --add sata --controller IntelAHCI --portcount 4 --hostiocache off

%vboxm% storageattach %vmname% --storagectl storage --port 1 --medium "C:\Users\%USERNAME%\VirtualBox VMs\%vmname%\%vmname%.vdi" --type hdd

%vboxm% storageattach %vmname% --storagectl storage --port 2 --medium C:\var\varvamp\files\ubuntu-14.04.3-server-amd64-unattended.iso --type dvddrive

%vboxm% modifyvm %vmname% --boot1 dvd

%vboxm% startvm %vmname% 


:# %vboxm% startvm %vmname% --type=headless
:  %vboxm% controlvm %vmname% poweroff
:  %vboxm% controlvm %vmname%  acpipowerbutton

:get info from another vm..
:%vboxm% import -n C:\0\ubuntu201.ova

::http://crysol.github.io/recipe/2013-10-05/virtualbox-import-export-clone/#.VhQzPxFVhBc
::%vboxm% export %vmname% -o "C:\var\varvamp\files\%vmname%_%ymd%-%macaddvamp%-rand%random%.ova" --manifest

:%vboxm%  modifyhd "C:\Users\%USERNAME%\VirtualBox VMs\%vmname%\%vmname%.vdi"  --resize 13920

pause
