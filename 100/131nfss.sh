#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#server redek210..

#no... https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-12-04
#https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-14-04

sudo apt-get install nfs-kernel-server portmap

sudo mkdir /var/nfs/
sudo chown nobody:nogroup /var/nfs

sudo cat <<EOF >> /etc/exports
# -------------------------------------------------------------------
# David Gleba 
/home           192.168.88.63(rw,sync,no_root_squash,no_subtree_check)
/var/nfs        192.168.88.63(rw,sync,no_subtree_check)
#
EOF

sudo exportfs -a
sudo service nfs-kernel-server start




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

