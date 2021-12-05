#!bin/bash

height=30
width=30

function window () { 
	dialog --backtitle 'TOXICSTIC ARCH INSTALL SCRIPT $@'
}

displayManager=$(window --menu "Please select your prefered display manager (login manager)" $height $width 3 1 Chromium 2 Firefox 3 Qutebrowser)

echo $displayManager
