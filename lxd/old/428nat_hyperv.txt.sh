exit 8


>41.

to login to the lxc container from its host..


lxc exec lx21 -- sudo --login --user ubuntu


>51.

delete iptables rules..



#delete all prerouting...

sudo iptables -t nat -L PREROUTING --line-numbers
   for i in $( sudo iptables -t nat --line-numbers -L | grep ^[0-9] | awk '{ print $1 }' | tac ); do sudo iptables -t nat -D PREROUTING $i; done
sudo iptables -t nat -L PREROUTING --line-numbers




#  DELETE ALL  - CAREFULL   **************************
sudo iptables -t nat -L PREROUTING
# for i in $( sudo iptables -t nat --line-numbers -L | grep ^[0-9] | awk '{ print $1 }' | tac ); do sudo iptables -t nat -D PREROUTING $i; done
sudo iptables -t nat -L PREROUTING --line-numbers
 


>61.

setup the nat rules when on hyperv or bare metal... Uses different ports

# get container ip by reading this..
lxc list

 
#    *****   Edit the IP addresses below...   *****  

# export PUBLIC_IP=10.0.2.15;
export PUBLIC_IP=192.168.88.46;
#
export CONTAINER_IP=10.99.1.22;
#
export PubPORT=3542; 
export CPORT=80;
#
# export 
#
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT
#
export PubPORT=3541; 
export CPORT=22;
#
sudo iptables -t nat -A PREROUTING -d $PUBLIC_IP -p tcp --dport $PubPORT -j DNAT --to $CONTAINER_IP:$CPORT
sudo iptables -t nat -L PREROUTING --line-numbers
 


>91.

sudo netfilter-persistent save
sudo netfilter-persistent flush
sudo netfilter-persistent reload




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 
sudo /etc/init.d/networking restart
   