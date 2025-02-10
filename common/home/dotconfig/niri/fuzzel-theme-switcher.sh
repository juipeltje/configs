#!/usr/bin/env bash

# Theme switcher script for Niri

theme=$( echo -e "󰔎  Nordic\n󰔎  Gruvbox-Material-Dark\n󰔎  Tokyo-Night" | fuzzel -d --width=13 --placeholder="Select a theme:" | awk '{print $2}' )

case $theme in
	Nordic)
		sed -i --follow-symlinks 's|active-color.*|active-color "#8fbcbb"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#4c566a"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include nordic.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
		killall mako
		mako -c ~/.config/mako/nordic-config &
		killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "nordic.css";|' ~/.config/waybar/style.css
		waybar &
		gsettings set org.gnome.desktop.interface gtk-theme Nordic
		sed -i --follow-symlinks 's|^include.*|include=~/.config/fuzzel/nordic.ini|' ~/.config/fuzzel/fuzzel.ini
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/.config/niri/autostart.sh
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
		sed -i --follow-symlinks 's|active-color.*|active-color "#dfbf8e"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#665c54"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include gruvbox-material-dark.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
                killall mako
                mako -c ~/.config/mako/gruvbox-material-dark-config &
                killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "gruvbox-material-dark.css";|' ~/.config/waybar/style.css
                waybar &
		gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Material-Dark
		sed -i --follow-symlinks 's|^include.*|include=~/.config/fuzzel/gruvbox-material-dark.ini|' ~/.config/fuzzel/fuzzel.ini
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/.config/niri/autostart.sh
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
		sed -i --follow-symlinks 's|active-color.*|active-color "#a9b1d6"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#565f89"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include tokyo-night.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
                killall mako
                mako -c ~/.config/mako/tokyonight-config &
                killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "tokyonight.css";|' ~/.config/waybar/style.css
                waybar &
		gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark
		sed -i --follow-symlinks 's|^include.*|include=~/.config/fuzzel/tokyonight.ini|' ~/.config/fuzzel/fuzzel.ini
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/.config/niri/autostart.sh
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
