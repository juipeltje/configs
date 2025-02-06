#!/usr/bin/env bash

# autostart script for hyprland

pipewire &
hyprpaper &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-hyprland",|' ~/.config/waybar/config
waybar &
mako &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
~/repos/configs/scripts/cron/battery-low.sh &
~/repos/configs/scripts/cron/battery-full.sh &
~/repos/configs/scripts/cron/charger.sh &
