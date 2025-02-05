#!/usr/bin/env bash

# autostart script for swayfx

kitty --class scratchpad &
pipewire &
autotiling --splitratio 1.61 --limit 2 &
waybar -c ~/.config/waybar/sway-config &
mako -c ~/.config/mako/gruvbox-material-dark-config &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
~/repos/configs/scripts/cron/battery-low.sh &
~/repos/configs/scripts/cron/battery-full.sh &
~/repos/configs/scripts/cron/charger.sh &
sed -i --follow-symlinks 's/^output.*/output = /' ~/.config/tofi/config &
