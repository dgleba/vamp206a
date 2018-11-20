#!/usr/bin/env bash



# Step 1


cd
# if need be, get prompt for sudo password...
sudo ls
#
sudo apt-get update && \
sudo apt-get -y install git mc ncdu wget curl && \
cd ; git clone https://github.com/dgleba/vamp206a.git shc  ; chmod -R +x  shc/  && \
cd ; cd shc ; git pull




# Step 2
  


# 2a.
# edit or put env file in safe/vne.sh on the target machine. (otherwise it will use the supplied env data from a2/21env.sh

# 2b.
# put sample data in /home/$userv/tmp01/htdocs.pmdsdata3.latest.7z if you don't want to use the supplied sample data.



    
    

# Step 3


#Step 3 and 4 will run setup.. 
#  it will..
#  - install sw  
#  - create data folders and permissions  
#  - import sample data  




# docker example..  32init, custom1 is permissions, then 81docker.sh

 

# Logout and login  [or.. exec bash ] after running this next line so that the settings are activated...

cd ; sudo chmod -R +x shc/ ; sudo shc/a3/32init.sh 2>&1 | tee -a 32init_v206_log$(date +"__%Y-%m-%d_%H.%M.%S").log && exec bash

## ---------------   logout and login again. or  -  exec bash ----------------------- 




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
