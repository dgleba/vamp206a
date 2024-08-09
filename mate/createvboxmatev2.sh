:create vbox empty...  linux

#: this is a linux script file.
#: edit paths and names throughout this file...

# get random mac addr
#:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#:create the vm
vboxmanage createvm --name redekmatev2 --ostype Ubuntu_64 --register

vboxmanage modifyvm redekmatev2 --memory 1212 --cpus 1  --acpi on   --clipboard bidirectional

# worked..
vboxmanage modifyvm redekmatev2  --nic1 bridged --nictype1 virtio --bridgeadapter1 eth0

#:
#:shared folders...
#:
sudo mkdir /var/share206
#sudo rmdir /var/share206
sudo chown albe /var/share206

vboxmanage sharedfolder remove redekmatev2 --name share206
vboxmanage sharedfolder add redekmatev2 --name share206 --hostpath /var/share206/ 

vboxmanage createhd --filename "/home/albe/VirtualBox VMs/redekmatev2/redekmatev2.vdi" --size 114240 --format vdi

vboxmanage  storagectl redekmatev2 --name storage --add sata  --controller IntelAHCI 

vboxmanage storageattach redekmatev2 --storagectl storage --port 1 --medium "/home/albe/VirtualBox VMs/redekmatev2/redekmatev2.vdi" --type hdd

vboxmanage storageattach redekmatev2 --storagectl storage --port 2 --medium /home/albe/var/ubuntu-mate-15.10-desktop-amd64.iso  --type dvddrive

vboxmanage modifyvm redekmatev2 --boot1 dvd

#rename from vamp206b to vamp206c and start it
vboxmanage startvm redekmatev2


