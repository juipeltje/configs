#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n󰤄Hibernate\n Lock\n󰗽 Logout" | rofi -dmenu -p "Powermenu:" -theme-str 'window {width: 200px;}' | awk '{print tolower($2)}' )

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
		i3-lock
                ;;
        logout)
                qtile cmd-obj -o cmd -f shutdown
		i3-msg exit
                ;;
esac
