
:use 198e at work.
cd C:\n\Dropbox\csd\serve\vagrantyard\vamp198e

::if redwe, then ...
SET _prefix=%COMPUTERNAME:~0,5% 
IF %_prefix%==REDWE  cd C:\n\Dropbox\csd\serve\vagrantyard\vamp198f

vagrant global-status

: to remove invalid entries..
:vagrant global-status --prune


:pause