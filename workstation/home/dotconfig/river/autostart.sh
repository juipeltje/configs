#!/usr/bin/env bash

# autostart script for River

kanshi &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-gruvbox-material-dark.css &
mako -c ~/.config/mako/gruvbox-material-dark-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
xrandr --output DP-1 --primary &
alsactl --file ~/.config/asound.state restore &
