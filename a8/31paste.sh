#!/usr/bin/env bash


# ---------------------------------------------------

##  Step 3

exec bash

nuser.sh albe

sudo adduser albe sudo
sudo adduser albe docker
sudo mkdir -p /ap
sudo chown albe:albe /ap
sudo chown albe:www-data /ap

exec bash

# done


# ---------------------------------------------------
