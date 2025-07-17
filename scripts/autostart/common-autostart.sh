#!/usr/bin/env bash

# common autostart script to be executed by window managers.
mako -c ~/.config/mako/gruvbox-dark-config &
pipewire &
nm-applet &
blueman-applet &
playerctld &
swayidle -w &
