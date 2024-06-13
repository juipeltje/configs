#!/bin/bash

op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n Lock\n󰗽 Logout" | rofi -dmenu -p "Powermenu:" -theme-str 'window {width: 5%;}' | awk '{print tolower($2)}' )

case $op in
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
                loginctl $op
                ;;
        lock)
		i3-lock
                ;;
        logout)
                qtile cmd-obj -o cmd -f shutdown
                ;;
esac
