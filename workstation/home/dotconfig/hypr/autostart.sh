#!/usr/bin/env bash

# autostart script for hyprland

pipewire &
hyprpaper &
waybar -c ~/.config/waybar/hyprland-config -s ~/.config/waybar/hyprland-style.css &
hyprctl setcursor phinger-cursors-light 24 &
mako &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
openrgb --startminimized -p team-red.orp &
xrandr --output DP-1 --primary &
