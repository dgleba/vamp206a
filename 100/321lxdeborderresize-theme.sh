#!/usr/bin/env bash
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Purpose() {
# begin block comment =============================
: <<'END'

#  Purpose:  change window decorator border size

I am using the Onyx theme

http://unix.stackexchange.com/questions/178145/lxde-openbox-add-resize-corner-to-the-window

/usr/share/themes/Onyx/openbox-3/themerc

window.handle.width: 0
border.width: 1
window.active.border.color: #2E86C1
window.inactive.border.color: #404040

END
# end block comment ===============================
}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd ; date ; set +vx  ; set -vx ; # echo off, then echo on
#

# Main: put code here...


sudo cp  /usr/share/themes/Onyx/openbox-3/themerc  /usr/share/themes/Onyx/openbox-3/themerc$(date +"__%Y.%m.%d_%H.%M.%S").bk
# remove line containing  '?????'  and replace the line completely with the new text...
sudo sed -i "s/.*window.handle.width.*/window.handle.width: 2/g" /usr/share/themes/Onyx/openbox-3/themerc
sudo sed -i "s/.*border.width.*/border.width: 7/g" /usr/share/themes/Onyx/openbox-3/themerc
sudo sed -i "s/.*window.active.border.color.*/window.active.border.color: #2E86C1/g" /usr/share/themes/Onyx/openbox-3/themerc
sudo sed -i "s/.*window.inactive.border.color.*/window.inactive.border.color: #D4E6F1/g" /usr/share/themes/Onyx/openbox-3/themerc
openbox --reconfigure


#
date
#
