#!/bin/bash

# script for turning on secondary monitor and restoring wallpapers

xrandr --output DisplayPort-0 --primary --mode 3440x1440 --rate 165.00 --output DisplayPort-1 --mode 2560x1080 --rate 74.99 --above DisplayPort-0 &
sleep 5
/home/joppe/.fehbg &
