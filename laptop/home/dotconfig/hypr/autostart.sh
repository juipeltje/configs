#!/usr/bin/env bash

# autostart script for hyprland

gtklock -d &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-hyprland",|' ~/.config/waybar/config
waybar &
mako -c ~/.config/mako/catppuccin-mocha-config &
nm-applet &
blueman-applet &
