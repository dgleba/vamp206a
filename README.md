# Virtual Server Setup Scripts - Docker Ubuntu Apache MySQL PHP Python Django etc..

Scripts to setup a Server, usually virtual, for Docker, Ubuntu, Python, Ruby, Node, PHP, etc. 

It originally started as Script to create a Virtualbox Web Server - Ubuntu Apache MySQL PHP Python Django - Windows host, Linux guest.

[https://github.com/dgleba/vamp206a](https://github.com/dgleba/vamp206a)

---

# Latest usage instructions  (see \a9\...

Lately, I have been using a trimmed down provisioning routine.
It is in `\a9\` folder.

It is mostly to setup docker, a few aliases, some security software, and not much more.



# OTHER INSTRUCTIONS..

These are older, but they show some perspective of the change over time. Some stuff at the beginning may be out of date, but the ideas may be useful in understanding the current status and how to use this project.



# `\a3\` usage instructions...

See `a3\11prep.sh` for the latest setup scripts.

I have been recently doing things in steps.

I install ubuntu in a vbox vm manually. It just has user, timezone, US keyboard, and openssh-server. 

I start that vm and export an appliance. 

That appliance is just an unused ubuntu vm. I can erase my used vm and import a fresh unused applicance and start over anytime.

I also use snapshots in virtualbox. I take a snapshot when it is unused. I can restore that snapshot anytime and start over.

The `lxd` folder has lxd container setup scripts.

The `rails` folder has rails setup scripts.

When using `17docs-sample.sh` it just uses a sample web root and data-set to get things started. Then I use `a2\99newdata.sh` to get new data.


---

The instructions below for `version A1` refer to making a server from just the scripts. 
It downloads the ubuntu iso file, creates an unattended install ISO file, runs it to install ubuntu in a newly created vm, and installs all the software and data.
That code is in the `a1` folder now.


---

# Virtualbox Server - Ubuntu Apache MySQL PHP Python Django - Windows host, Linux guest.


# Version `A1`

  
## Overview

- Create Unattended Ubuntu Iso.
- Create virtualbox machine and install iso.
- after the vm is started, login to it. 
- run 11get.sh to get the latest code.
- edit your settings - like passwords.
- run 24start.sh to setup the web server and settings.
- visit a web page on the finished server.

## Caution

The unattended iso has a timeout of about 20 seconds on boot, then it goes ahead and wipes the entire disk and installs itself with no warning or quesitons!
It is unattended! You have been warned!


## Alternative Preparation

- Things are always changing due to advancements and of course I learn more as I go forward.
- Rather than using FTP locally to get some setup files, I have been using an alternate approach..
- I since have employed ssh (putty, mremoteNG, git bash, windows command prompt, etc) and filezilla to interact with the server, especially at the early stages.
- Use filezilla (over ssh / sftp) to put  `vne.sh`  `htdocs.pmdsdata3.latest.7z` in `/home/albe/tmp01` and `11get.sh`  in `~ `

## Preparation

- create basic folders.  `c:\var\varvamp\files`,  Possible optional `c:\var\share203`,  
- put iso here, C:\var\varvamp\files\ubuntu-14.04.3-server-amd64.iso, or let it download it for you.
- I put a copy of my served web root files in `C:\var\varvamp\files\htdocs.pmds-data.latest.7z`  
    say for example it contains `htdocs\menu\index.html` in the 7z file.  
	Ask me for a sample website and data. 
- I put an edited 21env.sh in 	`C:\var\varvamp\files\vne.sh` It was used rather than the one in the repo.
- I ran `vboxmanage list bridgedifs`  to get a list of adapter names to use in  `--bridgeadapter1 `  --  see `09createvbox.bat`.  
- I used 02startftp.bat to start an ftp server on a windows machine to serve up the web code, some settings, etc... Sorry, it has hardcoded paths in it. You can use those paths as is, edit the file to suit your system or just manually do what the script does yourself.
- Starting around line 90 in 17docs.sh edit the ip address which is now 192.168.88.94 to your local windows host ip address. This is where it will get the data from by ftp using slimftp.


## Usage - This is how I used it.

I am doing this on a Windows machine. (I used a Vagrant Ubuntu machine running in windows to create the iso).

- See preparation below.
- Install virtualbox
- create unattended ubuntu 14.04 server iso 
        ( I used a vagrant Ubuntu VM to create it. vamp198e https://bitbucket.org/dgleba/vamp198e)   
      See instructions for unattended iso maker below...   
	    vagrant share...   config.vm.synced_folder "/var/varvamp", "/var/varvamp"
      I used `04prep-iso.sh`  
      I used username albe, it may involve some work to use another username. albe is intentionally a unique name - it's just a name I use for the master user.
- create the virtual box  ( I did this from windows)  
  `07createvbox.bat`  
   This will also do an unattended install of the resulting Ubuntu 14.04 64bit server iso in vbox.    
- after the vbox ubuntu server boots, log in with user albe password a , run   
	`sudo ./11get.sh`   
   note: if black screen after it boots up after installing...  press ctrl-alt-f1 to get login prompt 
- copy shc/21env-example.sh to 21env.sh and edit to agree with your settings.  
       
- run  `sudo shc/24start.sh`    
    This runs the other files.
- visit in your browser: `[ip-address]/menu` or any other address that leads to the web content you placed in `C:\var\varvamp\files\htdocs.pmds-data.latest.7z`  
  - type `ifconfig` in the server console to get the ip of the machine.



## Example addresses of code I served up.

- http://10.4.10.249:8985/django161c/admin/
- http://10.4.10.249/dgnote130/
- http://10.4.10.249/authbasic/
- http://10.4.10.249/menu/
- http://10.4.10.249/test2/strap179/

# Older info

also see https://github.com/dgleba/vamp203


_____________
_____________
_____________


# Using Unattended Ubuntu ISO Maker

[forked from https://github.com/netson/ubuntu-unattended]

This simple script will create an unattended Ubuntu ISO from start to finish. It will ask you a few questions once, and embed your answers into a remastered ISO file for you to use over and over again.

This script creates a 100% original Ubuntu installation; no additional software is added (aside from the VMWare OSP Tools, which are optional), not even an ```apt-get update``` is performed. You have all the freedom in the world to customize your Ubuntu installation whichever way you see fit. This script just takes the pain out of re-installing Ubuntu over and over again.

Consider using tools like chef or puppet to perform any additional software installations/configurations. 

Created by: **Rinck Sonnenberg (Netson)**

## Compatibility

The script supports the following Ubuntu editions out of the box:

* Ubuntu 12.04.4 Server LTS amd64 - Precise Pangolin
* Ubuntu 14.04.2 Server LTS amd64 - Trusty Tahr

This script has been tested on and with these two versions as well, but I see no reason why it shouldn't work with other Ubuntu editions. Other editions would require minor changes to the script though.

## Usage

* From your command line, run the following commands:

```
$ wget https://raw.githubusercontent.com/netson/ubuntu-unattended/master/create-unattended-iso.sh
$ chmod +x create-unattended-iso.sh
$ sudo ./create-unattended-iso.sh
```

* Choose which version you would like to remaster:

```
 +---------------------------------------------------+
 |            UNATTENDED UBUNTU ISO MAKER            |
 +---------------------------------------------------+

 which ubuntu edition would you like to remaster:

  [1] Ubuntu 12.04.4 LTS Server amd64 - Precise Pangolin
  [2] Ubuntu 14.04.2 LTS Server amd64 - Trusty Tahr

 please enter your preference: [1|2]:
```

* Enter your desired timezone; the default is *Europe/Amsterdam*:

```
 please enter your preferred timezone: Europe/Amsterdam
```

* Enter your desired username; the default is *netson*:

```
 please enter your preferred username: netson
```

* Enter the password for your user account; the default is *empty*

```
 please enter your preferred password:
```

* Confirm your password:

```
 confirm your preferred password:
```

* Sit back and relax, while the script does the rest! :)

## What it does

This script does a bunch of stuff, here's the quick walk-through:

* It asks you for your preferences regarding the unattended ISO
* Downloads the appropriate Ubuntu original ISO straight from the Ubuntu servers; if a file with the exact name exists, it will use that instead (so it won't download it more than once if you are creating several unattended ISO's with different defaults)
* Downloads the netson preseed file; this file contains all the magic answers to auto-install ubuntu. It uses the following defaults for you (only showing most important, for details, simply check the seed file in this repository):
 * Language/locale: en_US
 * Keyboard layout: US International
 * Root login disabled (so make sure you write down your default usernames' password!)
 * Partitioning: LVM, full disk, single partition
* Install the mkpasswd program (part of the whois package) to generate a hashed version of your password
* Install the genisoimage program to generate the new ISO file
* Mount the downloaded ISO image to a temporary folder
* Copy the contents of the original ISO to a working directory
* Set the default installer language
* Add/update the preseed file
* Add the autoinstall option to the installation menu
* Generate the new ISO file
* Cleanup
* Show a summary of what happended:

```  
 installing required packages
 remastering your iso file
 creating the remastered iso
 -----
 finished remastering your ubuntu iso file
 the new file is located at: /tmp/ubuntu-14.04.2-server-amd64-unattended.iso
 your username is: netson
 your password is: 
 your hostname is: ubuntu
 your timezone is: Europe/Amsterdam
```

### Once Ubuntu is installed ...

Just fire off the start.sh script in your users' home directory to complete the installation. This will ask you if you would like to add the puppetlabs repositories for puppet and its dependencies and if you would also like to setup the puppet agent

```$ sudo ~/start.sh``` 

### That's it, enjoy! :)

## Troubleshooting

If you run into any issues, please create an issue; I am by no means a shell/bash expert (far from it), and it took me a while to compile this script into something that's easy to use and just works, but I'm happy to help where I can! :)

## License
MIT 

Unattended Ubuntu ISO Maker - Created by: **Rinck Sonnenberg (Netson)**
 
_____________

Credits:

https://github.com/netson/ubuntu-unattended
https://github.com/panique/vagrant-lamp-bootstrap
https://github.com/mattandersen/vagrant-lamp

Also see credits.txt

_____________


https://github.com/dgleba/vamp206a  

MIT license:

Copyright (c) 2015 David Gleba  

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
