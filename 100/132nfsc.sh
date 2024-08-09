#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#on client....


sudo apt-get install nfs-common portmap

sudo mkdir -p /mnt/nfs/home
sudo mkdir -p /mnt/nfs/var/nfs

sudo mount 192.168.88.64:/home /mnt/nfs/home
sudo mount 192.168.88.64:/var/nfs /mnt/nfs/var/nfs

df -h
mount -t nfs


sudo cat <<EOF >> /etc/fstab
# -------------------------------------------------------------------
# David Gleba 
192.168.88.64:/home    /mnt/nfs/home   nfs auto,noatime,nolock,bg,nfsvers=4,intr,tcp,actimeo=1800 0 0
192.168.88.64:/var/nfs    /mnt/nfs/var/nfs   nfs auto,noatime,nolock,bg,nfsvers=4,sec=krb5p,intr,tcp,actimeo=1800 0 0
#
EOF




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline()
{
exit 999
# begin block comment =============================
: <<'END'

comment content
ls

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
date
#

