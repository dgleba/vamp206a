
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  docker install
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2022-12-03[Dec-Sat]23-26PM 

# https://hedge.daveg.win/k4mJo5emQvyHDiqyQGOUNg#Install-docker-with-ubuntu-repository

# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

# select all and paste all into terminal..



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

