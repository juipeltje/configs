#!/usr/bin/env bash

# autostart script for qtile-wayland

pipewire &
swaybg -i ~/Pictures/sway/background.jpg -m fill &
mako -c ~/.config/mako/nordic-config &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
~/repos/configs/scripts/cron/battery-low.sh &
~/repos/configs/scripts/cron/battery-full.sh &
~/repos/configs/scripts/cron/charger.sh &
mpd &
mpDris2 &
