#!/usr/bin/env bash

# common autostart script to be executed by qtile.
#gtklock -d &
swaybg -i ~/Pictures/background/background.jpg -m fill &
kanshi &
mako -c ~/.config/mako/gruvbox-dark-config &
pipewire &
/usr/libexec/polkit-gnome-authentication-agent-1 &
blueman-applet &
playerctld &
#swayidle -w &
