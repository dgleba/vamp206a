#!/usr/bin/env bash

# setup ssh keys so you have passwordless login to the new remote server..


s=localhost
p=3541
u=albe
echo $u $s$p;
#cat ~/.ssh/id_rsa.pub | ssh $u@$s - $p "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

ssh $u@$s - $p  

# execute s1r local script on the new remote server.

ssh $u@$s - $p  "bash -s" -- < ./03s1r.sh


sleep 3


# check to see if it had effect..

ssh $u@$s - $p  "history"

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
