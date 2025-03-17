#!/usr/bin/env bash

# script for autostarting applications in i3

autotiling --splitratio 1.61 --limit 2 &
sleep 1
xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --mode 2560x1080 --rate 74.99 --above DisplayPort-0 &
~/.fehbg &
dunst &
playerctld daemon &
lxpolkit &
xset s off -dpms &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
mpd &
mpDris2 &
