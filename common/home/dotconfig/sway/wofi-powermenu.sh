#!/bin/bash

op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n Lock\n󰗽 Logout" | tofi --width=200 --placeholder-text="Powermenu:" | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                loginctl $op
                ;;
        lock)
		swaylock
                ;;
        logout)
                swaymsg exit
                ;;
esac
