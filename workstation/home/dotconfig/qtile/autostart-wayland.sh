#!/usr/bin/env bash

# autostart script for qtile-wayland

pipewire &
kanshi &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
mako -c ~/.config/mako/gruvbox-dark-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
