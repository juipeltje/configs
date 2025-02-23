#!/usr/bin/env bash

# Compositor switcher script for Fuzzel

op=$( echo -e "  Sway\n  River\n  Niri" | fuzzel -d -w 12 --placeholder="Select a compositor:" | awk '{print tolower($2)}' )

case $op in
        sway)
                ;&
        river)
                ;&
        niri)
		sed -i --follow-symlinks "s|exec dbus-run-session.*|exec dbus-run-session $op|" ~/.bash_profile
		swaymsg exit
		riverctl exit
                niri msg action quit -s
		hyprctl dispatch exit
                ;;
esac
