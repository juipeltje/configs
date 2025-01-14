#!/usr/bin/env bash

# autostart script for swayfx

pipewire &
autotiling --splitratio 1.61 --limit 2 &
waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-nordic.css &
mako -c ~/.config/mako/nordic-config &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
