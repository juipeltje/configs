#!/bin/bash

# Theme switcher script for SwayFX

theme=$( echo -e "Nordic\nGruvbox-Material-Dark\nTokyo-Night" | wofi --show dmenu)

case $theme in
	nordic)
		notify-send "Switching to Nordic theme..."
		sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-nordic.conf|' ~/.config/sway/config
		swaymsg reload
		sed -i 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/.config/alacritty/alacritty.toml
		killall mako
		mako -c ~/.config/mako/nordic-config &
		killall waybar
		waybar -c ~/.config/waybar/sway-nordic-config -s ~/.config/waybar/sway-style-nordic.css &
		notify-send "Current theme: Nordic"
		;;
	gruvbox-material-dark)
		notify-send "Switching to Gruvbox-Material-Dark theme..."
                sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-gruvbox-material-dark.conf|' ~/.config/sway/config
                swaymsg reload
                sed -i 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/.config/alacritty/alacritty.toml
                killall mako
                mako -c ~/.config/mako/gruvbox-material-dark-config &
                killall waybar
                waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-gruvbox-material-dark.css &
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	tokyo-night)
		notify-send "Switching to Tokyo-Night theme..."
                sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-tokyonight.conf|' ~/.config/s>
                swaymsg reload
                sed -i 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/.config/alacritty/alacritty.t>
                killall mako
                mako -c ~/.config/mako/tokyonight-config &
                killall waybar
                waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-tokyonight.css &
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
