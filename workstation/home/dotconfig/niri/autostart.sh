#!/usr/bin/env bash

# autostart script for Niri

#kitty --class scratchpad &
pipewire &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-niri",|' ~/.config/waybar/config
waybar &
mako -c ~/.config/mako/nordic-config &
playerctld daemon &
lxpolkit &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
#sed -i --follow-symlinks 's/^output.*/output = /' ~/.config/tofi/output &
xwayland-satellite &
