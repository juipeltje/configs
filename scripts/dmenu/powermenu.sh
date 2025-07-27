#!/usr/bin/env bash

# Powermenu script
if [ -n "$WAYLAND_DISPLAY" ]; then
	op=$( echo -e "  Poweroff\n  Reboot\n󰒲  Suspend\n󰤄  Hibernate\n  Lock" | fuzzel -d -w 8 --placeholder="Powermenu:" | awk '{print tolower($2)}' )
else
	op=$( echo -e " Poweroff\n Reboot" | rofi -dmenu -p "Powermenu:" -theme-str 'window {width: 200px;}' | awk '{print tolower($2)}' )
fi

hostname=$(cat /etc/hostname)

case $op in
        poweroff)
                ;&
        reboot)
		;&
	hibernate)
		loginctl $op
		;;
        suspend)
		if [ "$hostname" = "Void-Rig" ]; then
			loginctl $op
		elif [ "$hostname" = "Void-Lappie" ]; then
			loginctl suspend-then-hibernate
		fi
		;;
        lock)
		gtklock -d --follow-focus --poweroff-command="" --reboot-command=""
                ;;
esac
