:Prepare date and temp folders
set timea=%TIME: =0%
set ymd=%date:~12,2%%date:~4,2%%date:~7,2%&set dhms=%date:~12,2%%date:~4,2%%date:~7,2%_%timea:~0,2%%timea:~3,2%%timea:~6,2%
c: & md c:\temp\log\"%dhms%"  & cd c:\temp\log\"%dhms%"
:main
:goto skip1

rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ start here..
:: don't include the prjfold that is a couple lines below.
set srcdir=\\10.4.10.220\html\django
::next item is in the above folder.
set prjfold=cilistsite
set bkdir=c:\backup\cilistsite
set bkfname=cilistsite
set dbxcpy=C:\n\Dropbox\csd\copyof
rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %bkfname%
:Title:
:7z-gpb = 7zip generic project folder backup routine...  David Gleba 2015-07-10

mkdir %bkdir%

del "%bkdir%\%bkfname%.%computername%.7z"
:timeout 2

:backup...
C:\n\Dropbox\csd\p2\7-Zip\7z.exe a -y -t7z  -xr!static\   "%bkdir%\%bkfname%.%computername%-vm.vamp206a.%dhms%.7z"  %srcdir%\%prjfold%  %srcdir%\apache

:copy
mkdir %dbxcpy%\%prjfold%
copy "%bkdir%\%bkfname%.%computername%-vm.vamp206a.%dhms%.7z" %dbxcpy%\%prjfold%\%bkfname%.%computername%.vm.vamp206a.latest.7z



rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %bkfname%












:..........  offline items  ................................................
goto end
goto end
goto end
:#######

timeout 3777
C:\p\1ziptar\7-Zip\7z.exe d -y -t7z -xr!vendor -xr!.svn "c:\n\dropbox\csd\copyof\dgn146\dgn146a.wgit.%computername%.7z" *.* -r
timeout 9
:use swiss file knife to change line endings to unix.
sfk174 remcr -dir C:\p2\xampp\htdocs\1test\alexgarrettmvc170 -yes

:echo ran,7zxata-dgnote130,%computername%,"%dhms%" >> C:\p2\xampp\htdocs\dgnote130\documents\bkuplogs\7zxata-dgnote130-runlog.%computername%.csv

copy "c:\backup\laravelelkins\lelkins-starter.%dhms%.%computername%.7z" "C:\n\Dropbox\csd\copyof\laravelelkins\lelkins-starter.latest.%computername%.7z"
goto :end

C:\p\1ziptar\7-Zip\7z.exe a -y -t7z  -xr!templates_c  -xr!.git -xr!.svn -xr!.hg "c:\backup\dgnote130\dgnote130.xata.%dhms%.%computername%.7z" C:\p2\xampp\htdocs\dgnote130 
:skip1
:delete-uneeded then copy only date range
rmdir c:\temp\tmp\prodrpt  /s /q & mkdir c:\temp\tmp\prodrpt   
xcopy  C:\p2\xampp\htdocs\prodrpt\*.* c:\temp\tmp\prodrpt  /s/h/i/f/c/k/y /d:03-20-2013

:delete-uneeded then copy only x days old
rmdir c:\temp\tmp\prodrpt  /s /q 
robocopy C:\p2\xampp\htdocs\prodrpt  c:\temp\tmp\prodrpt /xd "templates_c"  /maxage:1 /s /ndl /ts /np /fft /dst  /r:0 /w:9 /tee /log:"c:rb-prdt-%dhms%-%random%"
C:\p\1ziptar\7-Zip\7z.exe  a -y -t7z "c:\backup\prodrpt\prodrpt.2days.xata.%dhms%.7z"  c:\temp\tmp\prodrpt 

:#######
:end
pause