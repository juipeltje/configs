#!/bin/bash

# autostart script for River

wlr-randr --output DP-1 --mode 3440x1440@164.998993 --pos 0,1080 --output DP-2 --mode 2560x1080@74.990997 --pos 0,0 &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-tokyonight.css &
mako -c ~/.config/mako/tokyonight-config &
pipewire &
playerctld daemon &
lxpolkit &
liquidctl initialize all &
sleep 2
liquidctl --match kraken set pump speed 100 &
~/repos/configs/scripts/yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
nm-applet &
openrgb &
xrandr --output DP-1 --primary &
