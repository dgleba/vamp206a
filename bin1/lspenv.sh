#!/bin/bash
#set -vx


echo -e "\n## ------------------------------------- lspenv.sh. $HOSTNAME $(date) \n"
echo -e "## Purpose: list python installations and some info. \n"

cat /etc/lsb-release;

echo -e "\n# compgen \n"

compgen -c python | sort -u 

echo -e "\n## python --version \n"
python --version
which python

echo -e "\n## python3 --version \n"
python3 --version
which python3

echo -e "\n## python3.8 --version \n"
python3.8 --version
which python3.8

echo -e "\n## python3.9 --version \n"
python3.9 --version
which python3.9 


echo -e "\n# info from py3. This may be the system python. \n"
python3 -c "import platform, sys; print('Operating System:', platform.system(), 'Python Version:', sys.version, 'Python Executable Path:', sys.executable, '\n',  sep='\n')"
# '\n',

