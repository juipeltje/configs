#!/bin/bash

# autostart script for hyprland

hyprpaper &
waybar -c /home/joppe/.config/waybar/hyprland-config -s /home/joppe/.config/waybar/hyprland-style.css &
hyprctl setcursor phinger-cursors-light 24 &
mako -c /home/joppe/.config/mako/hyprland-config &
playerctld daemon &
/usr/bin/lxpolkit &
nm-applet &
