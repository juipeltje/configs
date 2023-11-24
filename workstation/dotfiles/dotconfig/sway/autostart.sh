#!/bin/bash

# autostart script for swayfx

swaybg -i /home/joppe/Pictures/Wallpapers/Games/Nier/nier2.png -m fill &
waybar -c /home/joppe/.config/waybar/sway-config -s /home/joppe/.config/waybar/sway-style.css &
mako -c /home/joppe/.config/mako/sway-config &
pipewire &
playerctld daemon &
/usr/bin/lxpolkit &
liquidctl initialize all &
sleep 2
liquidctl --match kraken set pump speed 100 &
/home/joppe/repos/configs/Scripts/yoda.sh --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
nm-applet &
openrgb &
