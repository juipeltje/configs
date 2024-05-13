#!/usr/bin/env bash

# autostart script for hyprland

hyprpaper &
waybar -c /home/joppe/.config/waybar/hyprland-config -s /home/joppe/.config/waybar/hyprland-style.css &
mako -c /home/joppe/.config/mako/hyprland-config &
playerctld daemon &
lxsession &
nm-applet &
