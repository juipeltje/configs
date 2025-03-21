#!/usr/bin/env bash

# autostart script for hyprland

gtklock -d &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-hyprland",|' ~/.config/waybar/config
waybar &
hyprctl setcursor phinger-cursors-light 24 &
mako -c ~/.config/mako/catppuccin-mocha-config &
#playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
#mpd &
#mpDris2 &
