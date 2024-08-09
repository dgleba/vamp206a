#!/usr/bin/env bash


#  paste this into the command prompt on the new server..
#    use putty or some ssh client that you can paste text into..

#    use filezilla - connection over ssh to put files on the server
#      to edit files on the server right click on a file and select edit.
#      if you need to edit files as root, copy it to writable folder and then   
#         copy it over after editing, or just use sudo sed etc to edit the files.

  
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Step 1

# edit a2/24start.sh. 
#     use the mariadb `columnstore`  stanza or the `regularmysqlserver` stanza. Or edit as you wish.

cd
sudo apt-get update
sudo apt-get -y install git mc
#
cd ; git clone https://github.com/dgleba/vamp206a.git shc   



# Step 2
  


# 2a.
# edit or put env file in safe/vne.sh (otherwise it will use the supplied env data from a2/21env.sh

# 2b.
# put sample data in /home/$userv/tmp01/htdocs.pmdsdata3.latest.7z if you don't want to use the supplied sample data.



#---
    

# Step 3


#this will run setup.. 
#  it will..
#  - install sw  
#  - create data folders and permissions  
#  - import sample data  



cd ; cd shc ; git pull
cd ; sudo chmod -R +x shc/ ; sudo shc/a2/24start.sh 2>&1 | tee -a v206_start_log$(date +"__%Y-%m-%d_%H.%M.%S").log



# Step 4


# If you have not used the  regularmysqlserver stanza in a2/24start.sh then you can install mariadb columnstore...

# run apps/mcs/mariadbcolumnstore-step1.sh per the usage info at the top of that file..



# Step 5



# paste commands from  apps/mcs/mariadbcolumnstore-step2.sh



# done


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
