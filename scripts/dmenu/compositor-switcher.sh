#!/usr/bin/env bash

# Compositor switcher script
# arrays
options=(
  "   DWL\n"
  "  Hyprland\n"
 # "  i3\n"
  "  maomao\n"
  "  mwc\n"
  "  Niri\n"
 # "  Qtile\n"
  "  Qtile-wayland\n"
  "  River\n"
  "  SwayFX"
)

wayland_vars=(
  # make electron apps use wayland backend
  "ELECTRON_OZONE_PLATFORM_HINT=wayland"
)

# Variables
dbus=dbus-run-session

if [ -n "$WAYLAND_DISPLAY" ]; then
	op=$( echo -e "${options[@]}" | fuzzel -d -w 12 --placeholder="Select a compositor:" | awk '{print tolower($2)}' )
else
	op=$( echo -e "${options[@]}" | rofi -dmenu -p "Select a compositor:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )
fi

# functions
exit_compositor() {
	# kill any programs that were autostarted.
	kill $(pgrep gtklock)
	kill $(pgrep swaybg)
	kill $(pgrep kanshi)
	kill $(pgrep waybar)
	kill $(pgrep mako)
	kill $(pgrep pipewire)
	kill $(pgrep nm-applet)
	kill $(pgrep blueman-applet)
	kill $(pgrep playerctld)
	kill $(pgrep swayidle)
	kill $(pgrep liquidctl)
	kill $(pgrep yoda)
	kill $(pgrep autotiling)
	kill $(pgrep ollama)
	kill $(pgrep xwayland-satellite)
	kill $(pgrep -f /usr/libexec/polkit-gnome-authentication-agent-1)
	kill $(pgrep -f /home/joppe/repos/configs/dotfiles/common/dotconfig/qtile/autostart.sh)
	kill $(pgrep -f /home/joppe/repos/configs/scripts/autostart/common-autostart.sh)
	kill $(pgrep -f /home/joppe/repos/configs/scripts/autostart/workstation-autostart.sh)
	kill $(pgrep -f /home/joppe/repos/configs/scripts/autostart/laptop-autostart.sh)
	kill $(pgrep -f /home/joppe/repos/configs/scripts/autostart/laptop/battery-full.sh)
	kill $(pgrep -f /home/joppe/repos/configs/scripts/autostart/laptop/battery-low.sh)
	kill $(pgrep -f /home/joppe/repos/configs/scripts/autostart/laptop/charger.sh)

	# kill running compositor.
	kill $(pgrep dwl)
	hyprctl dispatch exit
	# i3msg exit
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
		sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec ${dbus} dwl|${wayland_vars[@]} exec ${dbus} river|${wayland_vars[@]} exec ${dbus} maomao|${wayland_vars[@]} exec ${dbus} mwc|${wayland_vars[@]} exec ${dbus} niri|${wayland_vars[@]} exec ${dbus} sway|${wayland_vars[@]} exec ${dbus} qtile start -b wayland|exec ${dbus} startx ~\/.xinitrc-qtile|exec ${dbus} startx ~\/.xinitrc-i3|${wayland_vars[@]} exec ${dbus} Hyprland)/${wayland_vars[@]} exec ${dbus} $op/g" ~/.bash_profile
		exit_compositor
        	;;
	swayfx)
		sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec ${dbus} dwl|${wayland_vars[@]} exec ${dbus} river|${wayland_vars[@]} exec ${dbus} maomao|${wayland_vars[@]} exec ${dbus} mwc|${wayland_vars[@]} exec ${dbus} niri|${wayland_vars[@]} exec ${dbus} sway|${wayland_vars[@]} exec ${dbus} qtile start -b wayland|exec ${dbus} startx ~\/.xinitrc-qtile|exec ${dbus} startx ~\/.xinitrc-i3|${wayland_vars[@]} exec ${dbus} Hyprland)/${wayland_vars[@]} exec ${dbus} sway/g" ~/.bash_profile
		exit_compositor
		;;
	qtile)
		;&
	i3)
		sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec ${dbus} dwl|${wayland_vars[@]} exec ${dbus} river|${wayland_vars[@]} exec ${dbus} maomao|${wayland_vars[@]} exec ${dbus} mwc|${wayland_vars[@]} exec ${dbus} niri|${wayland_vars[@]} exec ${dbus} sway|${wayland_vars[@]} exec ${dbus} qtile start -b wayland|exec ${dbus} startx ~\/.xinitrc-qtile|exec ${dbus} startx ~\/.xinitrc-i3|${wayland_vars[@]} exec ${dbus} Hyprland)/exec ${dbus} startx ~\/.xinitrc-$op/g" ~/.bash_profile
        	exit_compositor
		;;
	qtile-wayland)
		sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec ${dbus} dwl|${wayland_vars[@]} exec ${dbus} river|${wayland_vars[@]} exec ${dbus} maomao|${wayland_vars[@]} exec ${dbus} mwc|${wayland_vars[@]} exec ${dbus} niri|${wayland_vars[@]} exec ${dbus} sway|${wayland_vars[@]} exec ${dbus} qtile start -b wayland|exec ${dbus} startx ~\/.xinitrc-qtile|exec ${dbus} startx ~\/.xinitrc-i3|${wayland_vars[@]} exec ${dbus} Hyprland)/${wayland_vars[@]} exec ${dbus} qtile start -b wayland/g" ~/.bash_profile
		exit_compositor
		;;
	hyprland)
        	sed -i -E --follow-symlinks "s/(${wayland_vars[@]} exec ${dbus} dwl|${wayland_vars[@]} exec ${dbus} river|${wayland_vars[@]} exec ${dbus} maomao|${wayland_vars[@]} exec ${dbus} mwc|${wayland_vars[@]} exec ${dbus} niri|${wayland_vars[@]} exec ${dbus} sway|${wayland_vars[@]} exec ${dbus} qtile start -b wayland|exec ${dbus} startx ~\/.xinitrc-qtile|exec ${dbus} startx ~\/.xinitrc-i3|${wayland_vars[@]} exec ${dbus} Hyprland)/${wayland_vars[@]} exec ${dbus} Hyprland/g" ~/.bash_profile
        	exit_compositor
        	;;
esac
