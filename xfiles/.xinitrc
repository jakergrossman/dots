#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
. /etc/X11/Xsession

# screen res/refresh
xrandr -s 1920x1080 -r 144

xrdb -merge ~/.Xresources
