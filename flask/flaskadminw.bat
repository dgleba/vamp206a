:Prepare date and temp folders - http://serverfault.com/questions/147515/need-leading-zero-for-batch-script-using-time-variable
set timea=%TIME: =0%
set ymd=%date:~12,2%%date:~4,2%%date:~7,2%&set dhms=%date:~12,2%%date:~4,2%%date:~7,2%_%timea:~0,2%%timea:~3,2%%timea:~6,2%
c: & md c:\temp\log\"%dhms%"  & cd c:\temp\log\"%dhms%"

:main
rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ std2

set wpy=c:\p2\python27\python
set wpip=c:\p2\Python27\Scripts\pip



mkdir C:\p2\xampp\htdocs\python\
cd C:\p2\xampp\htdocs\python\
c: 


:use git bash..
git clone https://github.com/flask-admin/flask-admin.git flask-admin


cd flask-admin

%wpip% install -r requirements-dev.txt
%wpip% install -r examples\layout\requirements.txt

set wpy=c:\p2\python27\python
%wpy% examples\layout\app.py

timeout 80

rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ std2







: offline items ---------------------------------------------------------
goto end
goto end
goto end


this is offline


: offline items ---------------------------------------------------------
:end
:pause
