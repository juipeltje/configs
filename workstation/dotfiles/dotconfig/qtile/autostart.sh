#!/bin/bash

# script for autostarting applications in qtile

sleep 1
xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --mode 2560x1080 --rate 74.99 --above DisplayPort-0 & 
/home/joppe/.fehbg &
picom &
dunst &
pipewire &
playerctld daemon &
/usr/bin/lxpolkit &
liquidctl initialize all &
sleep 2
liquidctl --match kraken set pump speed 100 &
/home/joppe/repos/configs/Scripts/yoda-nix.sh --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
xset s off -dpms &
nm-applet &
openrgb &


