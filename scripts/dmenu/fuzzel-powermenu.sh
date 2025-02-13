#!/usr/bin/env bash

op=$( echo -e "  Poweroff\n  Reboot\n󰒲  Suspend\n󰤄  Hibernate\n  Lock\n󰗽  Logout" | fuzzel -d -w 8 --placeholder="Powermenu:" | awk '{print tolower($2)}' )

case $op in
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
		;&
	hibernate)
                loginctl $op
                ;;
        lock)
		swaylock
                ;;
        logout)
		swaymsg exit
		riverctl exit
                niri msg action quit -s
		hyprctl dispatch exit
                ;;
esac
