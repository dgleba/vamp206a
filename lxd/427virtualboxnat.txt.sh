exit 8


rem Change to nat..


>11.

change virtual box nat rules to make the virtualbox vm accessible from the pc hosting the virtualboxvm..


set vmname=ubu335c5b-cloned
set vmname=ubu381
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
echo %vboxm%
: NAT...
%vboxm%  modifyvm %vmname% --nic1 nat
%vboxm%  modifyvm %vmname% --natpf1  delete "guestssh"
%vboxm%  modifyvm %vmname% --natpf1 "guestssh,tcp,,3541,,22"
%vboxm%  modifyvm %vmname% --natpf1  delete "guest80"
%vboxm%  modifyvm %vmname% --natpf1 "guest80,tcp,,3542,,80"

rem set vmname=ubu335c6
rem set vmname=ubu335c5b-cloned
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
echo %vboxm%
: NAT...
%vboxm%  modifyvm %vmname% --natpf1  delete "lx21ssh"
%vboxm%  modifyvm %vmname% --natpf1 "lx21ssh,tcp,,3551,,3551"
%vboxm%  modifyvm %vmname% --natpf1  delete "lx21htm80"
%vboxm%  modifyvm %vmname% --natpf1 "lx21htm80,tcp,,3552,,3552"

set vmname=ubu381
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
%vboxm%  modifyvm %vmname% --natpf1  delete "lx218985"
%vboxm%  modifyvm %vmname% --natpf1 "lx218985,tcp,,3553,,3553"

set vmname=ubu381
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
%vboxm%  showvminfo %vmname% |grep -i nic



# if dns not working..
set vmname=ubu381
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
%vboxm% modifyvm %vmname% --natdnshostresolver1 on



>21.

hmm. not needed..

rem  			check firewall in windows.



>31.

info..

ssh 10.4.10.118 3541 lxhost works.

ssh 10.4.10.118 3541   # lxhost



>41.

to login to the lxc container from its host..


lxc exec lx21 -- sudo --login --user ubuntu


>51.

delete iptables rules..


#  DELETE ALL  - CAREFULL   **************************
sudo iptables -t nat -L PREROUTING
# for i in $( sudo iptables -t nat --line-numbers -L | grep ^[0-9] | awk '{ print $1 }' | tac ); do sudo iptables -t nat -D PREROUTING $i; done
sudo iptables -t nat -L PREROUTING --line-numbers
 
 
#delete all prerouting...

sudo iptables -t nat -L PREROUTING --line-numbers
   for i in $( sudo iptables -t nat --line-numbers -L | grep ^[0-9] | awk '{ print $1 }' | tac ); do sudo iptables -t nat -D PREROUTING $i; done
sudo iptables -t nat -L PREROUTING --line-numbers



>61.

setup the nat rules on the vbox vm that is host to the lxc container...

# get container ip by reading this..
lxc list
sudo iptables -t nat -L PREROUTING --line-numbers

 
#    *****   Edit the IP addresses below...   *****  
# 
# export PUBLIC_IP=192.168.88.46;    # if on hyperv or baremetal, use the hosts ip address as the public ip and forward to the container.
export   PUBLIC_IP=10.0.2.15;        # use the private ip address of the nat vbox vm if using virtualbox..
#
export CONTAINER_IP=10.99.1.99;
#
export PubPORT=3552; 
export CPORT=80;
#
# export 
#
sudo iptables -t nat -L PREROUTING --line-numbers
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT
#
export PubPORT=3551; 
export CPORT=22;
#
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT

export PubPORT=3553; 
export CPORT=8985;
#
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT




sudo iptables -t nat -L PREROUTING --line-numbers



 
>81.  list vbox vm info..

set vmname=ubu335c6
set vmname=ubu335c5b-cloned
set vmname=ubu381
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
%vboxm%  showvminfo %vmname% |grep -i nic


>91.

sudo netfilter-persistent save
sudo netfilter-persistent flush
sudo netfilter-persistent reload




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~







notes







~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Title:  .
-----------------------2018-07-06[Jul-Fri]13-07PM

https://stgraber.org/2016/10/27/network-management-with-lxd-2-3/


https://discuss.linuxcontainers.org/t/using-static-ips-with-lxd/1291/4
works..

lxc stop c1
lxc network attach lxdbr0 c1 eth0 eth0
lxc config device set c1 eth0 ipv4.address 10.99.1.99
lxc start c1
lxc list


sudo apt -y install lxc1
sudo lxc-create -t ubuntu -n test22 -- --user albe --password a


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


set vmname=vamp206b
set vmname=ubu335c5
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage"  
::not using NAT...
 
  %vboxm%  modifyvm %vmname% --nic1 nat
  %vboxm%  modifyvm %vmname% --natpf1 "guestssh,tcp,,6032,,22"
  %vboxm%  modifyvm %vmname% --natpf1 "guest80,tcp,,6034,,80"

  

set vmname=ubu335c5
set vmname=ubu335c6
set vboxm="%VBOX_MSI_INSTALL_PATH%VBoxManage" 
: eg: VBoxManage modifyvm "VM name" --natpf1 delete "guestssh"

: NAT...
%vboxm%  modifyvm %vmname% --nic1 nat
%vboxm%  modifyvm %vmname% --natpf1 delete "guestssh"
%vboxm%  modifyvm %vmname% --natpf1 "guestssh,tcp,,3541,,22"
%vboxm%  modifyvm %vmname% --natpf1 delete "guest80"
%vboxm%  modifyvm %vmname% --natpf1 "guest80,tcp,,3542,,80"

  
%vboxm%  controlvm %vmname% nic1 nat
%vboxm%  controlvm %vmname% natpf1 delete "guestssh"
%vboxm%  controlvm %vmname% natpf1 "guestssh,tcp,,3541,,22"
%vboxm%  controlvm %vmname% natpf1 delete "guest80"
%vboxm%  controlvm %vmname% natpf1 "guest80,tcp,,3542,,80"

  
sudo /etc/init.d/networking restart
   
   
==   
