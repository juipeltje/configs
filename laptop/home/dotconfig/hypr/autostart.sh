#!/usr/bin/env bash

# autostart script for hyprland

hyprpaper &
waybar -c ~/.config/waybar/hyprland-config -s ~/.config/waybar/hyprland-style.css &
mako &
playerctld daemon &
lxsession &
nm-applet &
alsactl --file ~/.config/asound.state restore &
