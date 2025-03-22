#!/usr/bin/env bash

# autostart script for qtile-wayland

kanshi &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
mako -c ~/.config/mako/gruvbox-dark-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
mpd &
mpDris2 &
