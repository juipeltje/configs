#!/usr/bin/env bash

# autostart script for hyprland

hyprpaper &
waybar -c ~/.config/waybar/hyprland-config -s ~/.config/waybar/hyprland-style.css &
mako &
pipewire &
playerctld daemon &
lxsession &
nm-applet &
