#!/usr/bin/env bash

# autostart script for swayfx

gtklock -d &
kitty --class scratchpad &
pipewire &
autotiling --splitratio 1.61 --limit 2 &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-sway",|' ~/.config/waybar/config
waybar &
mako -c ~/.config/mako/gruvbox-material-dark-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
#sed -i --follow-symlinks 's/^output.*/output = /' ~/.config/tofi/output &
