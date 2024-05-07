#!/usr/bin/env bash


# ---------------------------------------------------

##  Step 3

exec bash


cd
tee ./provision02.sh <<- 'EOF'
# ---------------------------------------------------

# #
# git clone https://github.com/dgleba/vamp206a.git shc  ; chmod -R +x  shc/  && \
# cd shc ; git pull



# shc/bin1/nuser.sh albe

# sudo adduser albe sudo


# sudo adduser albe docker
# sudo mkdir -p /ap
# sudo chown albe:albe /ap
# sudo chown albe:www-data /ap

# exec bash


# install github..rupa/z - z-jump

  # cd $HOME
  # mkdir -p $HOME/bin
  # # git clone https://github.com/dgleba/z.git  bin/zjump
  # git clone https://github.com/rupa/z.git  bin/zjump
  # echo  export _Z_MAX_SCORE=12000>>$HOME/.bashrc
  # echo . $HOME/bin/zjump/z.sh>>$HOME/.bashrc
  # # execute .bashrc excluding the code that prevents running it again.
  # # tail -n+10 ~/.bashrc | bash

# # copy scripts to home bin folder..
# mkdir -p bin
  # chown -R $userv bin
  # chgrp -R $userv bin
# cd
# cp shc/bin1/* bin
  # chmod -R +x bin

# cd;
# export    fil=33alias.sh ; export pth=shc/acom ;  chmod +x $pth/$fil  ;  .  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;

cd;
# is this needed? Maybe already done??
#   export   fil=82docker.sh ; export pth=shc/acom ;  chmod +x $pth/$fil  ;  . $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;

# ---------------------------------------------------

EOF
chmod +x ~/provision02.sh;


export fil=provision02.sh ; export pth=~ ;  chmod +x $pth/$fil  ;  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;



# done
