#!/usr/bin/env bash

# read focused output with river-bedload/jq, and set the output in tofi config before running the powermenu script
sed -i --follow-symlinks "s/^output.*/output = $(river-bedload -print outputs | jq -r '.[] | select(.focused) | .name')/" ~/.config/tofi/config

op=$( echo -e " Poweroff\n Reboot\n󰒲 Suspend\n󰤄Hibernate\n Lock\n󰗽 Logout" | tofi --width=200 --placeholder-text="Powermenu:" | awk '{print tolower($2)}' )

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
                riverctl exit
                ;;
esac
