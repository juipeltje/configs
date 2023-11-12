#!/bin/bash

# autostart script for hyprland

hyprpaper &
waybar -c /home/joppe/.config/waybar/hyprland-config -s /home/joppe/.config/waybar/hyprland-style.css &
hyprctl setcursor capitaine-cursors-light 24 &
mako -c /home/joppe/.config/mako/hyprland-config &
pipewire &
playerctld daemon &
/usr/bin/lxpolkit &
nm-applet &
