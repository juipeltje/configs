#!/usr/bin/env bash

# Theme switcher script for SwayFX

theme=$( echo -e "󰔎 Nordic\n󰔎 Gruvbox-Material-Dark\n󰔎 Tokyo-Night" | tofi --width=300 --placeholder-text="Select a theme:" | awk '{print $2}' )

case $theme in
	Nordic)
		sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-nordic.conf|' ~/.config/sway/config
		swaymsg reload
		sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include nordic.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
		killall mako
		mako -c ~/.config/mako/nordic-config &
		killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "nordic.css";|' ~/.config/waybar/style.css
		waybar -c ~/.config/waybar/sway-config &
		gsettings set org.gnome.desktop.interface gtk-theme Nordic
		sed -i --follow-symlinks 's/^include.*/include = nordic-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
                sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-gruvbox-material-dark.conf|' ~/.config/sway/config
                swaymsg reload
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include gruvbox-material-dark.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
                killall mako
                mako -c ~/.config/mako/gruvbox-material-dark-config &
                killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "gruvbox-material-dark.css";|' ~/.config/waybar/style.css
                waybar -c ~/.config/waybar/sway-config &
		gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Material-Dark
		sed -i --follow-symlinks 's/^include.*/include = gruvbox-material-dark-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
                sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-tokyonight.conf|' ~/.config/sway/config
                swaymsg reload
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include tokyo-night.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
                killall mako
                mako -c ~/.config/mako/tokyonight-config &
                killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "tokyonight.css";|' ~/.config/waybar/style.css
                waybar -c ~/.config/waybar/sway-config &
		gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark
		sed -i --follow-symlinks 's/^include.*/include = tokyonight-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/.config/sway/autostart.sh
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
