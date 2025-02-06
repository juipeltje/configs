#!/usr/bin/env bash

# autostart script for River

pipewire &
kanshi &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
waybar -c ~/.config/waybar/river-config &
mako -c ~/.config/mako/gruvbox-material-dark-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
