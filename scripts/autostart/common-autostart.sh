#!/usr/bin/env bash

# common autostart script to be executed by window managers.
swaybg -i ~/Pictures/background/background.jpg -m fill &
kanshi &
mako -c ~/.config/mako/gruvbox-dark-config &
pipewire &
/usr/libexec/polkit-gnome-authentication-agent-1 &
nm-applet &
blueman-applet &
playerctld &
swayidle -w &
