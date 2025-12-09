
# step 1


# create albe user [if not already created]


# make sudo active, so it is already primed for the next steps...
sudo ls 


nuser=albe \
&& sudo adduser $nuser --gecos "$nuser,..,..,.."  \
&& sudo adduser $nuser sudo 

sudo usermod -a -G www-data $nuser; 
sudo usermod -a -G docker  $nuser;

groups $nuser;


# then logout and login as albe user.




