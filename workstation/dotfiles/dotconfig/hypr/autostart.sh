#!/bin/bash

# autostart script for hyprland

hyprpaper &
waybar -c /home/joppe/.config/waybar/hyprland-config -s /home/joppe/.config/waybar/hyprland-style.css &
hyprctl setcursor phinger-cursors-light 24 &
mako -c /home/joppe/.config/mako/hyprland-config &
pipewire &
playerctld daemon &
/usr/bin/lxpolkit &
liquidctl initialize all &
sleep 2
liquidctl --match kraken set pump speed 100 &
/home/joppe/repos/configs/Scripts/yoda.sh --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
nm-applet &
openrgb &
