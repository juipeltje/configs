#!/usr/bin/env bash

# Powermenu script
if [ -n "$WAYLAND_DISPLAY" ]; then
	op=$( echo -e "  Poweroff\n  Reboot\n󰒲  Suspend\n󰤄  Hibernate\n  Lock" | fuzzel -d -w 8 --placeholder="Powermenu:" | awk '{print tolower($2)}' )
else
	op=$( echo -e " Poweroff\n Reboot" | rofi -dmenu -p "Powermenu:" -theme-str 'window {width: 200px;}' | awk '{print tolower($2)}' )
fi

hostname=$( cat /etc/hostname )

case $op in
        poweroff)
                ;&
        reboot)
		;&
	hibernate)
		systemctl $op
		;;
        suspend)
		if [ "$hostname" = "NixOS-Rig" ]; then
			systemctl $op
		elif [ "$hostname" = "NixOS-Lappie" ]; then
			systemctl suspend-then-hibernate
		fi
		;;
        lock)
		gtklock -d --follow-focus
                ;;
esac
