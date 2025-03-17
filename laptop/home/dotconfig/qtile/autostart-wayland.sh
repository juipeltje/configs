#!/usr/bin/env bash

# autostart script for qtile-wayland

swaybg -i ~/Pictures/sway/background.jpg -m fill &
mako -c ~/.config/mako/nordic-config &
playerctld daemon &
lxsession &
nm-applet &
blueman-applet &
mpd &
mpDris2 &
