#!/usr/bin/env bash

# Powermenu script
if [ -n "$WAYLAND_DISPLAY" ]; then
	op=$( echo -e "  Poweroff\n  Reboot\n󰒲  Suspend\n󰤄  Hibernate\n  Lock" | fuzzel -d -w 8 --placeholder="Powermenu:" | awk '{print tolower($2)}' )
else
	op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n󰤄Hibernate\n Lock" | rofi -dmenu -p "Powermenu:" -theme-str 'window {width: 200px;}' | awk '{print tolower($2)}' )
fi

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
		gtklock -d
                ;;
esac
