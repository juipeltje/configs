#!/usr/bin/env bash

# autostart script for River

gtklock -d &
pipewire &
kanshi &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-river",|' ~/.config/waybar/config
waybar &
mako -c ~/.config/mako/gruvbox-material-dark-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
