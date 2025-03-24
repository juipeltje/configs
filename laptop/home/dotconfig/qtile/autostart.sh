#!/usr/bin/env bash

# script for autostarting applications in qtile

~/.fehbg &
picom &
dunst -conf ~/.config/dunst/dunstrc-gruvbox-material-dark &
xset s off -dpms &
nm-applet &
blueman-applet &
