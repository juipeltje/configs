#!/usr/bin/env bash

# autostart script for hyprland

pipewire &
hyprpaper &
waybar -c ~/.config/waybar/hyprland-config -s ~/.config/waybar/hyprland-style.css &
mako &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
~/repos/configs/scripts/cron/battery-low.sh &
~/repos/configs/scripts/cron/battery-full.sh &
~/repos/configs/scripts/cron/charger.sh &
