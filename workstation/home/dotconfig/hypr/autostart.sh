#!/usr/bin/env bash

# autostart script for hyprland

hyprpaper &
waybar -c ~/.config/waybar/hyprland-config -s ~/.config/waybar/hyprland-style.css &
hyprctl setcursor phinger-cursors-light 24 &
mako &
playerctld daemon &
lxsession &
liquidctl initialize all &
sleep 2
liquidctl --match kraken set pump speed 100 &
~/repos/configs/scripts/yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
nm-applet &
openrgb --startminimized -p team-red.orp &
xrandr --output DP-1 --primary &
alsactl --file ~/.config/asound.state restore &
