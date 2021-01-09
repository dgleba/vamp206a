
# step 1


# create albe user [if not already created]

sudo ls \
&& nuser=albe \
&& sudo adduser $nuser --gecos "$nuser,..,..,.."  \
&& sudo adduser $nuser sudo


# then logout and login as albe user.

