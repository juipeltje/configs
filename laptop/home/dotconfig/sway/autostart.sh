#!/usr/bin/env bash

# autostart script for swayfx

autotiling --splitratio 1.61 --limit 2 &
waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style.css &
mako &
playerctld daemon &
lxsession &
nm-applet &
