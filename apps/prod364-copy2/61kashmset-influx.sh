#!/usr/bin/env bash

saynow()
{
date1=$(date +"__%Y.%m.%d_%H.%M.%S")
echo $date1
timeout1=5 ; read -t "${timeout1}" -p "Press ENTER or wait $timeout1 seconds..." || true ;  echo ;
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function offline21() {

echo tmp1
exit 999

: <<'BLOCKCOMMENT'

  Purpose:   
        setup kashmiri1 server for PLC data historian with ingition OPCUA and influxdb etc.
            2017-02-16_Thu_13.54-PM


BLOCKCOMMENT
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#main...
saynow
#

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# In user albe:

sudo add-apt-repository ppa:webupd8team/java -y && sudo apt-get update
sudo apt-get -y install oracle-java8-installer

# have to accept license agreement.

cd
mkdir -p tmp01
cd tmp01

wget https://s3.amazonaws.com/files.inductiveautomation.com/release/ia/build7.9.1/20170125-1117/Ignition-7.9.1-linux-x64-installer.run
chmod +x Ignition-7.9.1-linux-x64-installer.run && sudo ./Ignition-7.9.1-linux-x64-installer.run

cd
cd tmp01
sudo apt-get -y install curl
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get -y install nodejs


wget https://dl.influxdata.com/influxdb/releases/influxdb_1.2.0_amd64.deb
sudo dpkg -i influxdb_1.2.0_amd64.deb


#
# add line after match... sed -i '/CLIENTSCRIPT="foo"/a CLIENTSCRIPT2="hello"' file
#
file1='/etc/influxdb/influxdb.conf'
# backup original file once..
if [ ! -f $file1.orig ] ; then sudo cp $file1 $file1.orig ; fi
sudo cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt
sudo cp $file1 $file1.bak.txt
pattern1='localhost'
line1=' \ \ bind-address = ":8098"'
sudo sed -i.$(date +"_%Y%m%d_%H%M%S").sed.txt "/$pattern1/a $line1" $file1
# restore to orig.. sudo cp $file1.orig $file1

#
# add line after match... sed -i '/CLIENTSCRIPT="foo"/a CLIENTSCRIPT2="hello"' file
#
file1='/etc/influxdb/influxdb.conf'
# backup original file once..
if [ ! -f $file1.orig ] ; then sudo cp $file1 $file1.orig ; fi
sudo cp $file1 $file1$(date +"__%Y.%m.%d_%H.%M.%S").bak.txt
sudo cp $file1 $file1.bak.txt
pattern1='^\[http\]'
line1=' \ \ enabled = true\n \ \ bind-address = ":8096" '
sudo sed -i.$(date +"_%Y%m%d_%H%M%S").sed.txt "/$pattern1/a $line1" $file1
# restore to orig.. sudo cp $file1.orig $file1


sudo systemctl start influxdb && sudo systemctl status influxdb
# this shows a vim prompt after starting. May want to figure out how to exit that automatically.

cd /srv/web

git clone https://github.com/coussej/node-opcua-logger.git
cd node-opcua-logger
sudo apt-get -y install npm
npm install


cd
cd tmp01

curl https://packagecloud.io/gpg.key | sudo apt-key add -
echo 'deb https://packagecloud.io/grafana/stable/debian/ jessie main' | sudo tee -a /etc/apt/sources.list
sudo apt-get update && sudo apt-get install -y grafana
#
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable grafana-server
#

