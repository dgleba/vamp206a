setlocal enableextensions
@echo off
mkdir c:\temp

:stop vagrant vm machines..

:use git bash to run the bash script in windows host...
echo.
echo shutdown vagrant machines...
echo.

:get error..  'while' is not recognized as an internal or external command, operable program or batch file.
:http://stackoverflow.com/questions/19878136/how-can-i-use-a-batch-file-to-write-to-a-text-file
::>c:\temp\vagranthaltall.sh  (echo  vagrant global-status | grep virtualbox | cut -c 1-9 | while read line; do echo $line; vagrant halt $line; done;)


timeout 0


cmd /c "sh --login -i -- c:\temp\vagranthaltall.sh"

echo.
echo run vghalt.sh...
cmd /c "sh --login -i -- C:\n\Dropbox\csd\p2\1\vghalt.sh"


:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:turn off all virtualbox vm's after vagrant machines are shutdown...

echo.
echo shutdown virtual box vm's..
echo.
c:
mkdir \temp

vboxmanage list runningvms > \temp\runningvms.txt
FOR /F delims^=^"^ tokens^=1 %%i in (\temp\runningvms.txt) do (
echo '%%i'
@echo on
echo.
vboxmanage controlvm "%%i" acpipowerbutton
)
echo.
echo ...reached the end of stopmvs.bat file. Good.
timeout 1
echo.
echo.

