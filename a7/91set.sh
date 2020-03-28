
. ~/12settings.sh


echo $* # echo off?


# sudo chmod -R 775 $hpath/shc
# sudo chmod -R 775 $hpath/bin2
 chown -R $userv $hpath
 chgrp -R $userv $hpath

# copy scripts to home bin folder..
mkdir -p bin
  chown -R $userv bin
  chgrp -R $userv bin
cd
cp shc/bin1/* bin
  chmod -R +x bin


# install github..rupa/z - z-jump
  cd $HOME
  mkdir -p $HOME/bin
  # git clone https://github.com/dgleba/z.git  bin/zjump
  git clone https://github.com/rupa/z.git  bin/zjump
  echo  export _Z_MAX_SCORE=11000>>$HOME/.bashrc
  echo . $HOME/bin/zjump/z.sh>>$HOME/.bashrc
  source $HOME/.bashrc
 

mkdir -p /srv/dkr
mkdir -p /srv/test
mkdir -p /srv/file
mkdir -p /srv/web
mkdir -p /srv/share


cd ; export fil=33alias.sh ; export pth=shc/a7 ;  chmod +x $pth/$fil  ;  .  $pth/$fil   2>&1 | tee -a ${fil}_log$(date +"__%Y-%m-%d_%H.%M.%S").log;
echo 'exit this shell now and login to get new settings.'
sleep 4
# exit # logout to get a fresh env by loging back in.



sudo  apt-get -y install git  && \
sudo  apt-get -y install git mc ncdu curl locate acl make build-essential  && \
sudo  apt-get -y install build-essential 
# sudo  apt-get -y install  autoremove purge


