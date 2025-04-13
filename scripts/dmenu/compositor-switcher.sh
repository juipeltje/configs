#!/usr/bin/env bash

# Compositor switcher script
if [ -n "$WAYLAND_DISPLAY" ]; then
	op=$( echo -e "  Hyprland\n  Niri\n  Qtile\n  Qtile-wayland\n  River\n  SwayFX" | fuzzel -d -w 12 --placeholder="Select a compositor:" | awk '{print tolower($2)}' )
else
	op=$( echo -e "  Hyprland\n  Niri\n  Qtile\n  Qtile-wayland\n  River\n  SwayFX" | rofi -dmenu -p "Select a compositor:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )
fi

exit_compositor() {
        systemctl --user stop sway-session.target
	systemctl --user stop river-session.target
	systemctl --user stop hyprland-session.target
	systemctl --user stop qtile-session.target
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
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|startx ~\/.xinitrc-qtile|Hyprland)/$op/g" ~/.bash_profile
		sed -i --follow-symlinks "s|\"include\".*|\"include\": \"~/.config/waybar/modules-$op\",|" ~/.config/waybar/config
		exit_compositor
                ;;
	swayfx)
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|startx ~\/.xinitrc-qtile|Hyprland)/sway/g" ~/.bash_profile
		sed -i --follow-symlinks "s|\"include\".*|\"include\": \"~/.config/waybar/modules-sway\",|" ~/.config/waybar/config
		exit_compositor
		;;
	qtile)
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|startx ~\/.xinitrc-qtile|Hyprland)/startx ~\/.xinitrc-qtile/g" ~/.bash_profile
		exit_compositor
		;;
	qtile-wayland)
		sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|startx ~\/.xinitrc-qtile|Hyprland)/qtile start -b wayland/g" ~/.bash_profile
		exit_compositor
		;;
	hyprland)
                sed -i -E --follow-symlinks "s/(river|niri|sway|qtile start -b wayland|startx ~\/.xinitrc-qtile|Hyprland)/Hyprland/g" ~/.bash_profile
		sed -i --follow-symlinks "s|\"include\".*|\"include\": \"~/.config/waybar/modules-$op\",|" ~/.config/waybar/config
                exit_compositor
                ;;
esac
