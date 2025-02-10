#!/usr/bin/env bash

op=$( echo -e "  Poweroff\n  Reboot\n󰒲  Suspend\n󰤄 Hibernate\n  Lock\n󰗽  Logout" | fuzzel -d -w 10 --placeholder="Powermenu:" | awk '{print tolower($2)}' )

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
                niri msg action quit -s
                ;;
esac
