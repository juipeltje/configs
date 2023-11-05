#!/bin/bash

# autostart script for hyprland

hyprpaper &
waybar &
hyprctl setcursor capitaine-cursors-light 24 &
mako &
pipewire &
playerctld daemon &
/usr/bin/lxpolkit &
liquidctl initialize all &
sleep 2
liquidctl --match kraken set pump speed 100 &
/home/joppe/repos/configs/Scripts/yoda-nix.sh --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
nm-applet &
openrgb &
