#!/bin/bash

# script for autostarting applications in the window manager

xrandr --output DisplayPort-0 --mode 3440x1440 --rate 165.00 &
/home/joppe/.fehbg &
picom &
dunst &
pipewire &
sleep 1
wireplumber &
pipewire-pulse &
playerctld daemon &
/usr/bin/lxpolkit &
/home/joppe/Scripts/liquidctl.sh &
/home/joppe/Scripts/yoda.sh --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
xset s off -dpms &
nm-applet &
openrgb &


