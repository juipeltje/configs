#!/usr/bin/env bash

# autostart script for qtile-wayland

kanshi &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
mako -c ~/.config/mako/catppuccin-mocha-config &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
