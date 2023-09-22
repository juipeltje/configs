#!/bin/bash

# script for autostarting applications in qtile

/home/joppe/.fehbg &
pipewire &
sleep 1
wireplumber &
pipewire-pulse &
picom &
dunst &
playerctld daemon &
/usr/bin/lxpolkit &
xset s off -dpms &
nm-applet &
