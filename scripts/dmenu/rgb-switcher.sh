#!/usr/bin/env bash

# RGB light color script for workstation
if [ -n "$WAYLAND_DISPLAY" ]; then
	color=$( echo -e "  Purple\n  Red" | fuzzel -d -w 12 --placeholder="Select RGB light color:" | awk '{print tolower($2)}' )
else
	color=$( echo -e " Purple\n Red" | rofi -dmenu -p "Select RGB light color:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )
fi

case $color in
        purple)
                ;&
        red)
		openrgb -p ${color}.orp
		sed -i "s|ExecStart = \"\${pkgs.openrgb}.*|ExecStart = \"\${pkgs.openrgb}/bin/openrgb --startminimized -p ${color}.orp\";|" ~/repos/configs/nixos/machines/workstation/home-manager/soystemd.nix
		sed -i "s|after-resume '\${pkgs.openrgb}.*|after-resume '\${pkgs.openrgb}/bin/openrgb -p ${color}.orp'|" ~/repos/configs/nixos/machines/common/home-manager/swayidle.nix
		notify-send "RGB Script" "Switched lighting color, running home manager switch..."
		home-manager switch --flake ~/repos/configs/nixos
		notify-send "RGB Script" "Done! current color: ${color}"
                ;;
esac
