#!/usr/bin/env bash

# autostart script for swayfx

gtklock -d &
kitty --class scratchpad &
pipewire &
autotiling --splitratio 1.61 --limit 2 &
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-sway",|' ~/.config/waybar/config
waybar &
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
#sed -i --follow-symlinks 's/^output.*/output = /' ~/.config/tofi/output &
