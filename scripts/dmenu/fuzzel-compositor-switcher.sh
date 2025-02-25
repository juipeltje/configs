#!/usr/bin/env bash

# Compositor switcher script for Fuzzel

op=$( echo -e "  SwayFX\n  River\n  Qtile\n  Niri" | fuzzel -d -w 12 --placeholder="Select a compositor:" | awk '{print tolower($2)}' )

case $op in
        river)
                ;&
        niri)
		sed -i --follow-symlinks "s|exec dbus-run-session.*|exec dbus-run-session $op|" ~/.bash_profile
		swaymsg exit
		riverctl exit
		qtile cmd-obj -o cmd -f shutdown
                niri msg action quit -s
		hyprctl dispatch exit
                ;;
	swayfx)
		sed -i --follow-symlinks "s|exec dbus-run-session.*|exec dbus-run-session sway|" ~/.bash_profile
		swaymsg exit
                riverctl exit
                qtile cmd-obj -o cmd -f shutdown
                niri msg action quit -s
                hyprctl dispatch exit
		;;
	qtile)
		sed -i --follow-symlinks "s|exec dbus-run-session.*|exec dbus-run-session qtile start -b wayland|" ~/.bash_profile
		swaymsg exit
                riverctl exit
                qtile cmd-obj -o cmd -f shutdown
                niri msg action quit -s
                hyprctl dispatch exit
		;;
esac
