#!/usr/bin/env bash

# RGB light color script for workstation
options=(
  "   Purple\n"
  "  Red"
)

if [ -n "$WAYLAND_DISPLAY" ]; then
	color=$( echo -e "${options[@]}" | fuzzel -d -w 12 --placeholder="Select RGB light color:" | awk '{print tolower($2)}' )
else
	color=$( echo -e "${options[@]}" | rofi -dmenu -p "Select RGB light color:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )
fi

case $color in
        purple)
                ;&
        red)
		openrgb -p ${color}.orp
		sed -i "s|^openrgb.*|openrgb -p ${color}.orp|" ~/repos/configs/scripts/autostart/workstation-autostart.sh
		sed -i --follow-symlinks "s|openrgb.*|openrgb -p ${color}.orp'|" ~/.config/swayidle/config
		notify-send "RGB Script" "Done! current color: ${color}"
                ;;
esac
