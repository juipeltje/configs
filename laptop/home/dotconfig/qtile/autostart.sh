#!/bin/bash

# script for autostarting applications in qtile

~/.fehbg &
picom &
dunst -conf ~/.config/dunst/dunstrc-gruvbox-material-dark &
pipewire &
playerctld daemon &
lxpolkit &
xsettingsd &
xset s off -dpms &
nm-applet &
