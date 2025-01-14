#!/usr/bin/env bash

# script for autostarting applications in qtile

pipewire &
~/.fehbg &
picom &
dunst -conf ~/.config/dunst/dunstrc-gruvbox-material-dark &
playerctld daemon &
lxpolkit &
xsettingsd &
xset s off -dpms &
nm-applet &
blueman-applet &
