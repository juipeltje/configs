#!/bin/bash

# autostart script for River

waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-tokyonight.css &
mako -c ~/.config/mako/tokyonight-config &
pipewire &
playerctld daemon &
lxsession &
nm-applet &
