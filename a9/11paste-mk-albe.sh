
# step 1


# create albe user [if not already created]

sudo ls \
&& nuser=albe \
&& sudo adduser $nuser --gecos "$nuser,..,..,.."  \
&& sudo adduser $nuser sudo 

sudo usermod -a -G www-data $nuser; 
sudo usermod -a -G docker  $nuser;

groups $nuser;


# then logout and login as albe user.


=================================================

or


ls \
&& nuser=alb2 \
&&  adduser $nuser --gecos "$nuser,..,..,.."  \
&&  adduser $nuser sudo


=================================================

problem:


on enwebhost: 

problem:

sudo: /usr/bin/sudo must be owned by uid 0 and have the setuid bit set

ans.

as root..
chmod u+s /usr/bin/sudo

=================================================

