#!/usr/bin/env bash

# setup metabase init script...

# Usage:  sudo /home/albe/bin/metabase_install-init.sh
#             sudo /etc/init.d/metabase1 start 
#             sudo /etc/init.d/metabase1 stop

# good general.. 2017-09-08_Fri_12.12-PM
# https://askubuntu.com/questions/99232/how-to-make-a-jar-file-run-on-startup-and-when-you-log-out
# https://github.com/metabase/metabase/issues/3063


source shc/21env.sh

cd
set +x
date

file1='/etc/init.d/metabase1'
tmpfile9='/tmp/heredoctmpfile99'

metainit()
{

sudo cat << 'HEREDOC'> $tmpfile9
#!/bin/bash

### BEGIN INIT INFO
# Provides:          metabase
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Should-Start:      $named
# Should-Stop:       $named
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start Metabase.
# Description:       Start Metabase BI analytics.
# Info about SysV init.d - http://www.pathbreak.com/blog/ubuntu-startup-init-scripts-runlevels-upstart-jobs-explained
### END INIT INFO

case "$1" in
    'start')
        /bin/bash /home/albe/bin/metabase_start1.sh
    ;;
    'stop')
        /bin/bash /home/albe/bin/metabase_stop1.sh
    ;;
    'restart')
        /bin/bash /home/albe/bin/metabase_stop1.sh
        /bin/bash /home/albe/bin/metabase_start1.sh
    ;;
esac
exit 0
#
HEREDOC

sudo cp $tmpfile9 $file1
chmod +x $file1
}


#main section.....................................................................

#echo requested commands...
set -x
date

metainit

update-rc.d metabase1 defaults

date
#




# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# problem with this is that the $1 in case $1 is not in the resulting file...

# sudo tee $file1<<EOF
# #!/bin/bash
# # metabase
# #
# # description: start and stop metabase BI analytics

# case "$1" in
    # 'start')
        # /bin/bash /home/albe/bin/metabase_start1.sh
    # ;;
    # 'stop')
        # /bin/bash /home/albe/bin/metabase_stop1.sh
    # ;;
    # 'restart')
        # /bin/bash /home/albe/bin/metabase_stop1.sh
        # /bin/bash /home/albe/bin/metabase_start1.sh
    # ;;
# esac
# exit 0
#
# EOF

