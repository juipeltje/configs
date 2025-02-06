#!/usr/bin/env bash

# autostart script for swayfx

kitty --class scratchpad &
pipewire &
autotiling --splitratio 1.61 --limit 2 &
waybar -c ~/.config/waybar/sway-config &
mako -c ~/.config/mako/gruvbox-material-dark-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
sed -i --follow-symlinks 's/^output.*/output = /' ~/.config/tofi/config &
