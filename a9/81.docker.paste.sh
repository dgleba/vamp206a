#!/usr/bin/env bash




# ---------------------------------------------------

# Install docker with ubuntu repository

# all in one. Just paste the stanza below into terminal...


sudo apt-get update \
&& \
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
&& \
sudo mkdir -m 0755 -p /etc/apt/keyrings \
&& \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
&& \
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
&& \
sudo apt-get update \
&& \
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin ; \
sudo usermod -aG docker $USER ; \
 docker --version ;
 
 




# ---------------------------------------------------

# Older. Use the above.


##  Docker problem


# I had error running docker-compose.
# posts indicated that uninstalling the distro supplied version and reinstalling would help. This fixed it.
# Run this file.

exec bash


cd;
# is this needed? Maybe already done? Run if need be.
#  export   fil=82docker.sh ; export pth=shc/acom ;  chmod +x $pth/$fil  ;  . $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;

# ---------------------------------------------------


# done
