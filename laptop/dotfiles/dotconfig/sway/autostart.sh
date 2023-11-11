#!/bin/bash

# autostart script for swayfx

swaybg -i /home/joppe/Pictures/wallpapers/games/Gravity-Rush/gravity-rush-2.png -m fill &
waybar -c /home/joppe/.config/waybar/sway-config -s /home/joppe/.config/waybar/sway-style.css &
mako -c /home/joppe/.config/mako/sway-config &
pipewire &
playerctld daemon &
/usr/bin/lxpolkit &
nm-applet &
