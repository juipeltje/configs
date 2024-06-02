#!/bin/bash

# Theme switcher script for SwayFX

theme=$( echo -e "󰔎 Nordic\n󰔎 Gruvbox-Material-Dark\n󰔎 Tokyo-Night" | tofi --width=300 --placeholder-text="Select your theme:" | awk '{print $2}' )

case $theme in
	Nordic)
		sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-nordic.conf|' ~/.config/sway/config
		swaymsg reload
		sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/.config/alacritty/alacritty.toml
		killall mako
		mako -c ~/.config/mako/nordic-config &
		killall waybar
		waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-nordic.css &
		gsettings set org.gnome.desktop.interface gtk-theme Nordic
		sed -i --follow-symlinks 's/^include.*/include = nordic-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/.config/sway/autostart.sh
		sed -i --follow-symlinks 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-nordic.css \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
                sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-gruvbox-material-dark.conf|' ~/.config/sway/config
                swaymsg reload
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/.config/alacritty/alacritty.toml
                killall mako
                mako -c ~/.config/mako/gruvbox-material-dark-config &
                killall waybar
                waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-gruvbox-material-dark.css &
		gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Material-Dark
		sed -i --follow-symlinks 's/^include.*/include = gruvbox-material-dark-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/.config/sway/autostart.sh
		sed -i --follow-symlinks 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-gruvbox-material-dark.css \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
                sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-tokyonight.conf|' ~/.config/sway/config
                swaymsg reload
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/.config/alacritty/alacritty.toml
                killall mako
                mako -c ~/.config/mako/tokyonight-config &
                killall waybar
                waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-tokyonight.css &
		gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark
		sed -i --follow-symlinks 's/^include.*/include = tokyonight-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/.config/sway/autostart.sh
		sed -i --follow-symlinks 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-tokyonight.css \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
