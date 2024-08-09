# usage: copy all and past. use this to create the script in ~/bin.

# dry run bakup koofr 1. additive copy.


mkdir -p $HOME/bin
f=$HOME/bin/bkkoofsh
tee $f <<- 'HEREDOC'

#!/bin/bash

# do it.

cd /am/cruc4tb/   &&   rclone copy         /am/cruc4tb/x/copyof/koofry2      koofry/   --exclude={/volums/**,*confCons-dg5-xps*,*trashed*}    -u  -v --modify-window 9s --dry-run

cd /am/cruc4tb/   &&   rclone sync koofry/ /am/cruc4tb/x/copyof/koofry2sync   --exclude={/volums/**,x.x}   -v --modify-window 9s  

cd /am/cruc4tb/   &&   rclone copy koofry/ /am/cruc4tb/x/copyof/koofry2   --exclude={/volums/**,*confCons-dg5-xps*,*trashed*}   -u -v --modify-window 9s  

echo -e "\n reached the end point."



notes_function () {

echo just notes.


# /am/cruc4tb/x/copyof  confCons-dg5-xps.xml

rclone backup 

dte=2023-12-12
d:\prg\rclone\rclone copy -v -u --max-age=$dte --min-age=1m d:/n/sfile      d:\x\rclbkup2023-12-07-sfile     --dry-run
d:\prg\rclone\rclone copy -v -u --max-age=$dte --min-age=1m d:/yard/koofd   d:\x\rclbkup2023-12-07-koofd     --dry-run
d:\prg\rclone\rclone copy -v -u --max-age=$dte --min-age=1m d:/yard/wkoofr2 d:\x\rclbkup2023-12-07-wkoofr2   --dry-run

----

set dte=2023-12-07
d:\prg\rclone\rclone copy -v -u --max-age=%dte% --min-age=1m d:/n/sfile      d:\x\rclbkup2023-12-07-sfile     --dry-run
d:\prg\rclone\rclone copy -v -u --max-age=%dte% --min-age=1m d:/yard/koofd   d:\x\rclbkup2023-12-07-koofd     --dry-run
d:\prg\rclone\rclone copy -v -u --max-age=%dte% --min-age=1m d:/yard/wkoofr2 d:\x\rclbkup2023-12-07-wkoofr2   --dry-run

------------

restore

#:::: d:\prg\rclone\rclone copy -v --max-age=$dte --min-age=1m    d:\x\rclbkup2023-12-07  d:/n/sfile  --dry-run
d:\prg\rclone\rclone copy -v -u --max-age=$dte --min-age=1m    d:\x\rclbkup2023-12-07-sfile  d:/n/sfile  --dry-run

}

HEREDOC



