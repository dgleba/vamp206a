:create vbox empty...  linux

#: this is a linux script file.
#: edit paths and names throughout this file...

# get random mac addr
#:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#:create the vm
vboxmanage createvm --name $orig_hostname --ostype Ubuntu_64 --register

vboxmanage modifyvm $orig_hostname --memory 512 --cpus 1  --acpi on   --clipboard bidirectional

# worked..
vboxmanage modifyvm $orig_hostname  --nic1 bridged --nictype1 virtio --bridgeadapter1 eth0

#:
#:shared folders...
#:
sudo mkdir /var/share206
#sudo rmdir /var/share206
sudo chown albe /var/share206

vboxmanage sharedfolder remove $orig_hostname --name share206
vboxmanage sharedfolder add $orig_hostname --name share206 --hostpath /var/share206/ 

vboxmanage createhd --filename "/home/albe/VirtualBox VMs/$orig_hostname/$orig_hostname.vdi" --size 114240 --format vdi

vboxmanage  storagectl $orig_hostname --name storage --add sata  --controller IntelAHCI 

vboxmanage storageattach $orig_hostname --storagectl storage --port 1 --medium "/home/albe/VirtualBox VMs/$orig_hostname/$orig_hostname.vdi" --type hdd

vboxmanage storageattach $orig_hostname --storagectl storage --port 2 --medium /home/albe/var/ubuntu-14.04.3-server-amd64-unattended.iso --type dvddrive

vboxmanage modifyvm $orig_hostname --boot1 dvd

#rename from vamp206b to vamp206c and start it
vboxmanage startvm vamp206c 

