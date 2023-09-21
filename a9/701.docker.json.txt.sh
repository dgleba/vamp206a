

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  removed this from 32pastemain.sh due to errors.
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2023-05-12[May-Fri]11-42AM 




sudo tee  -a /etc/docker/daemon.json <<- 'HEREDOC'
{
    "iptables": false,
    "dns" : [ "8.8.4.4" , "8.8.8.8" ]  
}
HEREDOC
cat /etc/docker/daemon.json


echo 'DOCKER_OPTS="--iptables=false"' | sudo tee -a /etc/default/docker
cat /etc/default/docker
# sudo nano /etc/default/docker
sudo service docker stop
sudo service docker start


=================================================


=================================================

error:   Temporary failure resolving 'deb.debian.org'


albe@ubu703:/ap/dkr/pmdm697-yardb/pm97bdjango$ docker run -it debian  bash
root@d993efd1070e:/# apt update
Err:1 http://deb.debian.org/debian bullseye InRelease
  Temporary failure resolving 'deb.debian.org'
All packages are up to date.
W: Failed to fetch http://deb.debian.org/debian/dists/bullseye/InRelease  Temporary failure resolving 'deb.debian.org'
W: Some index files failed to download. They have been ignored, or old ones used instead.

------------

albe@ubu703:/ap/dkr/pmdm697-yardb/pm97bdjango$ docker run busybox nslookup google.com
;; connection timed out; no servers could be reached

albe@ubu703:/ap/dkr/pmdm697-yardb/pm97bdjango$ nslookup google.com
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	google.com
Address: 142.251.32.78
Name:	google.com
Address: 2607:f8b0:400b:807::200e

------------

2: ens18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 1e:3d:72:0f:97:ed brd ff:ff:ff:ff:ff:ff
    altname enp0s18
    inet 192.168.88.55/24 brd 192.168.88.255 scope global dynamic noprefixroute ens18
       valid_lft 60260448sec preferred_lft 60260448sec
    inet6 fe80::2fee:bf58:8cb4:8bb2/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

=================================================

