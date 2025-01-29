#!/usr/bin/env bash

# autostart script for swayfx

kitty --class scratchpad &
pipewire &
autotiling --splitratio 1.61 --limit 2 &
waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-gruvbox-material-dark.css &
mako -c ~/.config/mako/gruvbox-material-dark-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
