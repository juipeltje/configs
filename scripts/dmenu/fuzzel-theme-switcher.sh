#!/usr/bin/env bash

# Theme switcher script for Fuzzel

theme=$( echo -e "󰔎  Nordic\n󰔎  Gruvbox-Material-Dark\n󰔎  Tokyo-Night" | fuzzel -d --width=14 --placeholder="Select a theme:" | awk '{print $2}' )

case $theme in
	Nordic)
		# sway
		sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-nordic.conf|' ~/.config/sway/config
		swaymsg reload
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/.config/sway/autostart.sh

		# river
		sed -i --follow-symlinks 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-nordic.sh|' ~/.config/river/common.sh
                ~/.config/river/colors-nordic.sh &
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/.config/river/autostart.sh

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#8fbcbb"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#4c566a"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/.config/niri/autostart.sh

		# alacritty
		sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/.config/alacritty/alacritty.toml

		# kitty
		sed -i --follow-symlinks 's|^include.*|include nordic.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)

		# mako
		killall mako
		mako -c ~/.config/mako/nordic-config &

		# waybar
		killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "nordic.css";|' ~/.config/waybar/style.css
		waybar &

		# fuzzel
		sed -i --follow-symlinks 's|^include.*|include=~/.config/fuzzel/nordic.ini|' ~/.config/fuzzel/fuzzel.ini

		# tofi
		sed -i --follow-symlinks 's/^include = colors.*/include = colors-nordic/' ~/.config/tofi/config

		# GTK
		gsettings set org.gnome.desktop.interface gtk-theme Nordic

		# done. notify user.
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
		# sway
		sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-gruvbox-material-dark.conf|' ~/.config/sway/config
		swaymsg reload
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/.config/sway/autostart.sh

		# river
		sed -i --follow-symlinks 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-gruvbox-material-dark.sh|' ~/.config/river/common.sh
                ~/.config/river/colors-gruvbox-material-dark.sh &
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/.config/river/autostart.sh

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#dfbf8e"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#665c54"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/.config/niri/autostart.sh

		# alacritty
		sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/.config/alacritty/alacritty.toml

		# kitty
		sed -i --follow-symlinks 's|^include.*|include gruvbox-material-dark.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)

		# mako
                killall mako
                mako -c ~/.config/mako/gruvbox-material-dark-config &

		# waybar
                killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "gruvbox-material-dark.css";|' ~/.config/waybar/style.css
                waybar &

		# fuzzel
		sed -i --follow-symlinks 's|^include.*|include=~/.config/fuzzel/gruvbox-material-dark.ini|' ~/.config/fuzzel/fuzzel.ini

		# tofi
		sed -i --follow-symlinks 's/^include = colors.*/include = colors-gruvbox-material-dark/' ~/.config/tofi/config

		# GTK
		gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Material-Dark

		# done. notify user
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
		# sway
		sed -i --follow-symlinks 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-tokyonight.conf|' ~/.config/sway/config
		swaymsg reload
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/.config/sway/autostart.sh

		# river
		sed -i --follow-symlinks 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-tokyonight.sh|' ~/.config/river/common.sh
                ~/.config/river/colors-tokyonight.sh &
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/.config/river/autostart.sh

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#a9b1d6"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#565f89"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/.config/niri/autostart.sh

		# alacritty
		sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/.config/alacritty/alacritty.toml

		# kitty
		sed -i --follow-symlinks 's|^include.*|include tokyo-night.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)

		# mako
                killall mako
                mako -c ~/.config/mako/tokyonight-config &

		# waybar
                killall waybar
		sed -i --follow-symlinks 's|^@import.*|@import "tokyonight.css";|' ~/.config/waybar/style.css
                waybar &

		# fuzzel
		sed -i --follow-symlinks 's|^include.*|include=~/.config/fuzzel/tokyonight.ini|' ~/.config/fuzzel/fuzzel.ini

		# tofi
		sed -i --follow-symlinks 's/^include = colors.*/include = colors-tokyonight/' ~/.config/tofi/config

		# GTK
		gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark

		# done. notify user
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
