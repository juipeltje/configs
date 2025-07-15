#!/usr/bin/env bash

# common autostart script to be executed by window managers.
mako -c ~/.config/mako/gruvbox-dark-config &
pipewire &
playerctld &
swayidle -w &
