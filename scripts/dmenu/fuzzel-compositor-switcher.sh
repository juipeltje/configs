#!/usr/bin/env bash

# Compositor switcher script for Fuzzel

op=$( echo -e "  River\n  Hyprland\n  Qtile\n  SwayFX\n  Niri" | fuzzel -d -w 12 --placeholder="Select a compositor:" | awk '{print tolower($2)}' )

exit_compositor() {
        systemctl --user stop sway-session.target
	systemctl --user stop river-session.target
	systemctl --user stop hyprland-session.target
	systemctl --user stop qtile-wayland-session.target
	systemctl --user stop niri-session.target
	systemctl --user stop graphical-session.target
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
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|Hyprland)/$op/g" ~/.bash_profile
		exit_compositor
                ;;
	swayfx)
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|Hyprland)/sway/g" ~/.bash_profile
		exit_compositor
		;;
	qtile)
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|Hyprland)/qtile start -b wayland/g" ~/.bash_profile
		exit_compositor
		;;
	hyprland)
                sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|Hyprland)/Hyprland/g" ~/.bash_profile
                exit_compositor
                ;;
esac
