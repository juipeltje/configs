#!/usr/bin/env bash

# autostart script for hyprland

gtklock -d &
hyprpaper &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-hyprland",|' ~/.config/waybar/config
waybar &
mako &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
mpd &
mpDris2 &
