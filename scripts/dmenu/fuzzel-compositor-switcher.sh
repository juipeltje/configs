#!/usr/bin/env bash

# Compositor switcher script for Fuzzel

op=$( echo -e "  SwayFX\n  River\n  Qtile\n  Niri" | fuzzel -d -w 12 --placeholder="Select a compositor:" | awk '{print tolower($2)}' )

exit_compositor() {
	swaymsg exit
        riverctl exit
        qtile cmd-obj -o cmd -f shutdown
        niri msg action quit -s
        hyprctl dispatch exit
}

case $op in
        river)
                ;&
        niri)
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland)/$op/g" ~/.bash_profile
		exit_compositor
                ;;
	swayfx)
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland)/sway/g" ~/.bash_profile
		exit_compositor
		;;
	qtile)
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland)/qtile start -b wayland/g" ~/.bash_profile
		exit_compositor
		;;
esac
