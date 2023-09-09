#!/bin/bash

# script for turning off the secondary monitor and restoring the wallpaper

xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --off &
sleep 5
/home/joppe/.fehbg &

