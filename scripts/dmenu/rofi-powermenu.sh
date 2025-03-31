#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n󰤄Hibernate\n Lock" | rofi -dmenu -p "Powermenu:" -theme-str 'window {width: 200px;}' | awk '{print tolower($2)}' )

case $op in
        poweroff)
                ;&
        reboot)
                ;&
        suspend)
		;&
	hibernate)
                systemctl $op
                ;;
        lock)
		i3-lock
                ;;
esac
