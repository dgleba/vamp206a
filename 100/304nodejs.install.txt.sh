
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@  
#@  used on kamatera . works.
#@  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   2020-11-21[Nov-Sat]17-39PM 



https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04



	cd ~
	curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh

Refer to the NodeSource documentation for more information on the available versions.

Inspect the contents of the downloaded script with nano (or your preferred text editor):

	nano nodesource_setup.sh

When you are satisfied that the script is safe to run, exit your editor, then run the script with sudo:

	sudo bash nodesource_setup.sh

The PPA will be added to your configuration and your local package cache will be updated automatically. You can now install the Node.js package in the same way you did in the previous section:

	sudo apt install nodejs

Verify that you’ve installed the new version by running node with the -v version flag:

	node -v

		Output
		v14.2.0


