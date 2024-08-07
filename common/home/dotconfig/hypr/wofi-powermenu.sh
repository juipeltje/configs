#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n Lock\n󰗽 Logout" | wofi --show dmenu --width 10% | awk '{print tolower($2)}' )

case $op in
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
		swaylock
                ;;
        logout)
                hyprctl dispatch exit
                ;;
esac
