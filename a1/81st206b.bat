: vbox win]

:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

: this is a windows batch file.
: edit paths and names throughout this file...

:set env variables... Edit these to your liking.
set vmname=vamp206b
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"
:
:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


:Prepare date and temp folders
set ymd=%date:~12,2%%date:~4,2%%date:~7,2%&set dhms=%date:~12,2%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

%vboxm% startvm %vmname% 


:# %vboxm% startvm %vmname% --type=headless
:  %vboxm% controlvm %vmname% poweroff
:  %vboxm% controlvm %vmname%  acpipowerbutton

timeout 299
