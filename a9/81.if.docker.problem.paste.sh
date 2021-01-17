#!/usr/bin/env bash


# ---------------------------------------------------

##  Docker problem


# I had error running docker-compose.
# posts indicated that uninstalling the distro supplied version and reinstalling would help. This fixed it.
# Run this file.

exec bash


cd;
# is this needed? Maybe already done? Run if need be.
  export   fil=82docker.sh ; export pth=shc/acom ;  chmod +x $pth/$fil  ;  . $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;

# ---------------------------------------------------


# done
