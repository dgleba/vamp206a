#!/bin/sh
set -e

cur=$(uname -r)
prev=$(readlink -f /vmlinuz.old) && prev=${prev#*-} || prev=@
keepkernels="^linux-(headers|image|image-extra)-($cur|$prev)"
allkernels='^linux-(headers|image|image-extra)-[0-9]'

[ root != "$USER" ] && { echo Error: must be root, aborting... >&2; exit 1; }
echo Cleaning apt cache...
apt-get clean

echo Removing no longer needed automatically installed packages...
apt-get autoremove

echo Removing old config files...
dpkg --get-selections | sed -n 's/\<deinstall$/purge/p' | dpkg --set-selections
dpkg -Pa

echo Removing old kernels...
apt-get --only-upgrade purge "$allkernels" "$keepkernels"+

echo Emptying every trashes...
rm -rf /home/*/.local/share/Trash/*/* >/dev/null 2>&1
rm -rf /root/.local/share/Trash/*/*   >/dev/null 2>&1

echo Script Finished!
