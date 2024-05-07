#!/bin/bash
# Grabs and kill a process from the pidlist that has the word  metabase.jar

pid=`ps aux | grep metabase.jar | awk '{print $2}'`
kill -9 $pid

set -vx
mv /home/albe/log/metabasebi.log /home/albe/log/metabasebi$(date +"__%Y.%m.%d_%H.%M.%S").log
set +vx

echo
echo Completed running metabase_stop1.sh.
echo