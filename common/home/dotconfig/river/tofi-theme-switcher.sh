#!/bin/bash

# Theme switcher script for River

theme=$( echo -e "󰔎 Nordic\n󰔎 Gruvbox-Material-Dark\n󰔎 Tokyo-Night" | tofi --width=300 --placeholder-text="Select a theme:" | awk '{print $2}' )

case $theme in
	Nordic)
		sed -i --follow-symlinks 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-nordic.sh|' ~/.config/river/common.sh
		~/.config/river/colors-nordic.sh &
		sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include nordic.conf|' ~/.config/kitty/kitty.conf
		kill -SIGUSR1 $(pgrep kitty)
		killall mako
		mako -c ~/.config/mako/nordic-config &
		killall waybar
		waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-nordic.css &
		gsettings set org.gnome.desktop.interface gtk-theme Nordic
		sed -i --follow-symlinks 's/^include.*/include = nordic-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/.config/river/autostart.sh
		sed -i --follow-symlinks 's|^waybar.*|waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-nordic.css \&|' ~/.config/river/autostart.sh
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
                sed -i --follow-symlinks 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-gruvbox-material-dark.sh|' ~/.config/river/common.sh
                ~/.config/river/colors-gruvbox-material-dark.sh &
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include gruvbox-material-dark.conf|' ~/.config/kitty/kitty.conf
		kill -SIGUSR1 $(pgrep kitty)
                killall mako
                mako -c ~/.config/mako/gruvbox-material-dark-config &
                killall waybar
                waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-gruvbox-material-dark.css &
		gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Material-Dark
		sed -i --follow-symlinks 's/^include.*/include = gruvbox-material-dark-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/.config/river/autostart.sh
		sed -i --follow-symlinks 's|^waybar.*|waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-gruvbox-material-dark.css \&|' ~/.config/river/autostart.sh
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
                sed -i --follow-symlinks 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-tokyonight.sh|' ~/.config/river/common.sh
                ~/.config/river/colors-tokyonight.sh &
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include tokyo-night.conf|' ~/.config/kitty/kitty.conf
		kill -SIGUSR1 $(pgrep kitty)
                killall mako
                mako -c ~/.config/mako/tokyonight-config &
                killall waybar
                waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-tokyonight.css &
		gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark
		sed -i --follow-symlinks 's/^include.*/include = tokyonight-colors/' ~/.config/tofi/config
		sed -i --follow-symlinks 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/.config/river/autostart.sh
		sed -i --follow-symlinks 's|^waybar.*|waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-tokyonight.css \&|' ~/.config/river/autostart.sh
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
