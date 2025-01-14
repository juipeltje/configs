#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n󰤄Hibernate\n Lock\n󰗽 Logout" | rofi -dmenu -theme-str 'window {width: 10%;}' | awk '{print tolower($2)}' )

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
                i3-msg exit
                ;;
esac
