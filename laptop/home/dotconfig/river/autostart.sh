#!/usr/bin/env bash

# autostart script for River

pipewire &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
waybar -c ~/.config/waybar/river-config &
mako -c ~/.config/mako/gruvbox-material-dark-config &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
~/repos/configs/scripts/cron/battery-low.sh &
~/repos/configs/scripts/cron/battery-full.sh &
~/repos/configs/scripts/cron/charger.sh &
