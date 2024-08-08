:export vbox empty...  [win]

:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

: this is a windows batch file.
: edit paths and names throughout this file...

:set env variables... Edit these to your liking.
set vmname=vamp206b
:set vmname=vamp206b-csd1
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"


:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


:Prepare date and temp folders
set ymd=%date:~12,2%%date:~4,2%%date:~7,2%&set dhms=%date:~12,2%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%


:# %vboxm% startvm %vmname% --type=headless
:  %vboxm% controlvm %vmname% poweroff
:  %vboxm% controlvm %vmname%  acpipowerbutton

:get info from another vm..
:%vboxm% import -n C:\0\ubuntu201.ova

::http://crysol.github.io/recipe/2013-10-05/virtualbox-import-export-clone/#.VhQzPxFVhBc
%vboxm% export %vmname% -o "C:\var\varvamp\files\%vmname%_%dhms%.ova" --manifest --ovf20
:%vboxm% export %vmname% -o "u:\vbox\%vmname%_%dhms%.ova" --manifest --ovf20

pause
