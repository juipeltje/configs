#!/usr/bin/env bash

# autostart script for River

gtklock -d &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-river",|' ~/.config/waybar/config
waybar &
mako -c ~/.config/mako/catppuccin-mocha-config &
nm-applet &
blueman-applet &
