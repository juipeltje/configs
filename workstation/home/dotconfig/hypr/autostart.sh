#!/usr/bin/env bash

# autostart script for hyprland

gtklock -d &
pipewire &
hyprpaper &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-hyprland",|' ~/.config/waybar/config
waybar &
hyprctl setcursor phinger-cursors-light 24 &
mako &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
