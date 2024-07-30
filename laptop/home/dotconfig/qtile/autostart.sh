#!/usr/bin/env bash

# script for autostarting applications in qtile

~/.fehbg &
picom &
dunst -conf ~/.config/dunst/dunstrc-gruvbox-material-dark &
playerctld daemon &
lxpolkit &
xsettingsd &
xset s off -dpms &
nm-applet &
alsactl --file ~/.config/asound.state restore &
