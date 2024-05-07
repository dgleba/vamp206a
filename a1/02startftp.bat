:setlocal enableextensions

c:
mkdir  c:\var\varvamp\files
:cd \var\varvamp\files

echo
echo I put the vamp206a files from the repo here manually myself...
echo
:
md C:\n\Dropbox\csd\serve\vboxyard\vamp206a
cd C:\n\Dropbox\csd\serve\vboxyard\vamp206a
rem I put the vamp206a files from the repo here manually myself...



pwd
timeout 2
copy /y lxdehome.tgz c:\var\varvamp\files
copy /y C:\n\Dropbox\csd\serve\vboxyard\vamp206env\vne.sh c:\var\varvamp\files
copy /y C:\n\Dropbox\csd\copyof\htdocs\htdocs.pmdsdata3.latest.7z c:\var\varvamp\files
copy /y C:\n\Dropbox\csd\serve\vboxyard\vamp206a\documents\mullvad\mullvadconfig-nl.zip c:\var\varvamp\files\mullvadconfig.zip
copy /y C:\n\Dropbox\csd\serve\vboxyard\vamp206a\04prep-iso.sh c:\var\varvamp\files

:Start ftp
mkdir c:\p2\slimftpd
: slimftpd.exe seems to get altered in git or something. have to zip it up. store in git, then unzip it...
:copy /y  C:\n\Dropbox\csd\serve\vboxyard\vamp206a\SlimFTPd.zip c:\p2\slimftpd
:copy /y  C:\n\Dropbox\csd\serve\vboxyard\vamp206a\SlimFTPd.exe c:\p2\slimftpd
copy /y  C:\n\Dropbox\csd\serve\vboxyard\vamp206a\slimftpd.conf c:\p2\slimftpd


cd c:\p2\slimftpd
:start slimftpd.exe
:http://stackoverflow.com/questions/17546016/how-can-you-zip-or-unzip-from-the-command-prompt-using-only-windows-built-in-ca
: not sure that this is....  expand C:\n\Dropbox\csd\serve\vboxyard\vamp206a\SlimFTPd.zip c:\p2\slimftpd\
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('C:\n\Dropbox\csd\serve\vboxyard\vamp206a\SlimFTPd.zip', 'c:\p2\slimftpd\'); }"
: I had no luck with powershell, so I am using 7z...
C:\n\Dropbox\csd\p2\7-Zip\7z.exe e -y -oc:\p2\slimftpd C:\n\Dropbox\csd\serve\vboxyard\vamp206a\SlimFTPd.zip 

start c:\p2\slimftpd\slimftpd.exe


timeout 0
pause
