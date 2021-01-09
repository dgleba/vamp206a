#!/usr/bin/env bash

# ---------------------------------------------------


#  paste commands below into the command prompt on the new server.
#    The server will need open-ssh-server installed. You can connect with username and password.
#    use putty or some ssh client that you can paste text into.
#     Other clients are mremote, windows ssh in command prompt. There are many others. 

#    Use filezilla - connection over ssh to put files on the server.
#      To edit files on the server right click on a file and select edit.
#      if you need to edit files as root, copy it to writable folder and then   
#         copy it back after editing, or just use sed or nano to edit the files.
#      Another option is cyberduck.


# ---------------------------------------------------




##  Step 1  as user albe - settings.


# get prompt for sudo. This will avoid sending pasted characters to the password prompt, which leads to them missing when they are needed.


# They way I paste commands, it usually has extra characters, like new lines. This can end up in the password prompt.
#   I need to backspace before entering my password.



sudo ls





# ---------------------------------------------------

