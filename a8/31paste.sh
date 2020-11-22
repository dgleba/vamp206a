#!/usr/bin/env bash


# ---------------------------------------------------

##  Step 3

exec bash

shc/bin1/nuser.sh albe

sudo adduser albe sudo
sudo adduser albe docker
sudo mkdir -p /ap
sudo chown albe:albe /ap
sudo chown albe:www-data /ap

exec bash

# done


cd;
export   fil=82docker.sh ; export pth=shc/acom ;  chmod +x $pth/$fil  ;  . $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;




# ---------------------------------------------------
