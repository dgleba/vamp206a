#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# netbeans and git cola git eye install..

sudo apt-get update

#https://www.digitalocean.com/community/tutorials/how-to-install-java-on-ubuntu-with-apt-get

sudo apt-get install default-jdk

cd tmp01
#sudo su -

#wget http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-php-linux.sh
 wget  http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-php-linux-x64.sh


chmod +x netbeans-8.1-php-linux-x64.sh
sh netbeans-8.1-php-linux-x64.sh



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function offline()
{
# begin block comment =============================
: <<'END'



python project plugin..


works in both windows and linux! 2015-07-20

instructions. how to install python support into netbeans.


https://blogs.oracle.com/geertjan/entry/python_in_netbeans_ide_81

dl:
http://plugins.netbeans.org/plugin/56795?show=true

unzip
C:\.\netbeansplugin,1419777594_python-with-basic-code-completion.zip

in netbeans.
tools
plugins
downloaded
add them all
install
_____________

Windows:  python platform manager:

i had to...
new project
python
new python
manage button near python platform
new
navigate to...  
		pick c:\p2\python27\python.exe
it filled everything else in.

see screen shot.
_____________

windows files:
C:\.\netbeans-sw-dg\netbeans-8.0.2-php-windows.exe
C:\.\1419777594_python-with-basic-code-completion-netbeansplugin.zip



END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#

