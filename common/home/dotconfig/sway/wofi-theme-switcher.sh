#!/bin/bash

# Theme switcher script for SwayFX

theme=$( echo -e "Nordic\nGruvbox-Material-Dark\nTokyo-Night" | wofi --show dmenu)

case $theme in
	Nordic)
		sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-nordic.conf|' ~/.config/sway/config
		swaymsg reload
		sed -i 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/.config/alacritty/alacritty.toml
		killall mako
		mako -c ~/.config/mako/nordic-config &
		killall waybar
		waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-nordic.css &
		sed -i 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/.config/sway/autostart.sh
		sed -i 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-nordic.css \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
                sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-gruvbox-material-dark.conf|' ~/.config/sway/config
                swaymsg reload
                sed -i 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/.config/alacritty/alacritty.toml
                killall mako
                mako -c ~/.config/mako/gruvbox-material-dark-config &
                killall waybar
                waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-gruvbox-material-dark.css &
		sed -i 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/.config/sway/autostart.sh
		sed -i 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-gruvbox-material-dark.css \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
                sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-tokyonight.conf|' ~/.config/sway/config
                swaymsg reload
                sed -i 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/.config/alacritty/alacritty.toml
                killall mako
                mako -c ~/.config/mako/tokyonight-config &
                killall waybar
                waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-tokyonight.css &
		sed -i 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/.config/sway/autostart.sh
		sed -i 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-tokyonight.css \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
