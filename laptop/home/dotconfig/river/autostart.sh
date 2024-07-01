#!/bin/bash

# autostart script for River

swaybg -i ~/Pictures/sway/background.jpg -m fill &
waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-gruvbox-material-dark.css &
mako -c ~/.config/mako/gruvbox-material-dark-config &
pipewire &
playerctld daemon &
lxsession &
nm-applet &
