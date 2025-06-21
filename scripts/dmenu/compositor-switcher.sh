#!/usr/bin/env bash

# Compositor switcher script
if [ -n "$WAYLAND_DISPLAY" ]; then
	op=$( echo -e "  DWL\n  Hyprland\n  i3\n  maomao\n  mwc\n  Niri\n  Qtile\n  Qtile-wayland\n  River\n  SwayFX" | fuzzel -d -w 12 --placeholder="Select a compositor:" | awk '{print tolower($2)}' )
else
	op=$( echo -e "  DWL\n  Hyprland\n  i3\n  maomao\n  mwc\n  Niri\n  Qtile\n  Qtile-wayland\n  River\n  SwayFX" | rofi -dmenu -p "Select a compositor:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )
fi

# arrays
wayland_vars=(
  # make electron apps use wayland backend
  "ELECTRON_OZONE_PLATFORM_HINT=wayland"
)

# functions
exit_compositor() {
	systemctl --user stop dwl-session.target
	systemctl --user stop hyprland-session.target
	systemctl --user stop i3-session.target
	systemctl --user stop maomao-session.target
	systemctl --user stop mwc-session.target
	systemctl --user stop niri-session.target
	systemctl --user stop qtile-session.target
    	systemctl --user stop qtile-wayland-session.target
	systemctl --user stop river-session.target
    	systemctl --user stop sway-session.target
	systemctl --user stop graphical-session.target
	kill $(pgrep dwl)
	hyprctl dispatch exit
	i3msg exit
	kill $(pgrep maomao)
	kill $(pgrep mwc)
	niri msg action quit -s
	qtile cmd-obj -o cmd -f shutdown
	riverctl exit
	swaymsg exit
}

case $op in
	dwl)
		;&
        river)
        	;&
	maomao)
		;&
	mwc)
		;&
        niri)
		sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec dwl|${wayland_vars[@]} exec river|${wayland_vars[@]} exec maomao|${wayland_vars[@]} exec mwc|${wayland_vars[@]} exec niri|${wayland_vars[@]} exec sway|${wayland_vars[@]} exec qtile start -b wayland|exec startx ~\/.xinitrc-qtile|exec startx ~\/.xinitrc-i3|${wayland_vars[@]} exec Hyprland)/${wayland_vars[@]} exec $op/g" ~/.bash_profile
		exit_compositor
        	;;
	swayfx)
		sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec dwl|${wayland_vars[@]} exec river|${wayland_vars[@]} exec maomao|${wayland_vars[@]} exec mwc|${wayland_vars[@]} exec niri|${wayland_vars[@]} exec sway|${wayland_vars[@]} exec qtile start -b wayland|exec startx ~\/.xinitrc-qtile|exec startx ~\/.xinitrc-i3|${wayland_vars[@]} exec Hyprland)/${wayland_vars[@]} exec sway/g" ~/.bash_profile
		exit_compositor
		;;
	qtile)
		;&
	i3)
		sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec dwl|${wayland_vars[@]} exec river|${wayland_vars[@]} exec maomao|${wayland_vars[@]} exec mwc|${wayland_vars[@]} exec niri|${wayland_vars[@]} exec sway|${wayland_vars[@]} exec qtile start -b wayland|exec startx ~\/.xinitrc-qtile|exec startx ~\/.xinitrc-i3|${wayland_vars[@]} exec Hyprland)/exec startx ~\/.xinitrc-$op/g" ~/.bash_profile
        	exit_compositor
		;;
	qtile-wayland)
		sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec dwl|${wayland_vars[@]} exec river|${wayland_vars[@]} exec maomao|${wayland_vars[@]} exec mwc|${wayland_vars[@]} exec niri|${wayland_vars[@]} exec sway|${wayland_vars[@]} exec qtile start -b wayland|exec startx ~\/.xinitrc-qtile|exec startx ~\/.xinitrc-i3|${wayland_vars[@]} exec Hyprland)/${wayland_vars[@]} exec qtile start -b wayland/g" ~/.bash_profile
		exit_compositor
		;;
	hyprland)
        	sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec dwl|${wayland_vars[@]} exec river|${wayland_vars[@]} exec maomao|${wayland_vars[@]} exec mwc|${wayland_vars[@]} exec niri|${wayland_vars[@]} exec sway|${wayland_vars[@]} exec qtile start -b wayland|exec startx ~\/.xinitrc-qtile|exec startx ~\/.xinitrc-i3|${wayland_vars[@]} exec Hyprland)/${wayland_vars[@]} exec Hyprland/g" ~/.bash_profile
        	exit_compositor
        	;;
esac
