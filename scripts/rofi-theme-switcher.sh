#!/usr/bin/env bash

# Theme switcher script for Qtile

theme=$( echo -e "󰔎 Nordic\n󰔎 Gruvbox-Material-Dark\n󰔎 Tokyo-Night" | rofi -dmenu -p "Select a theme:" -theme-str 'window {width: 300px;}' | awk '{print $2}' )

case $theme in
	Nordic)
		sed -i --follow-symlinks 's|^colors.*|colors = colors.Nordic|' ~/.config/qtile/common.py
		qtile cmd-obj -o cmd -f reload_config
		sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include nordic.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
		killall dunst
		dunst -conf ~/.config/dunst/dunstrc-nordic &
		sed -i 's|^Net/ThemeName.*|Net/ThemeName "Nordic"|' ~/.xsettingsd
		killall -HUP xsettingsd
		sed -i --follow-symlinks 's/^@theme.*/@theme "nordic"/' ~/.config/rofi/config.rasi
		sed -i --follow-symlinks 's|^dunst.*|dunst -conf ~/.config/dunst/dunstrc-nordic \&|' ~/.config/qtile/autostart.sh
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
                sed -i --follow-symlinks 's|^colors.*|colors = colors.GruvboxMaterialDark|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include gruvbox-material-dark.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
                killall dunst
                dunst -conf ~/.config/dunst/dunstrc-gruvbox-material-dark &
		sed -i 's|^Net/ThemeName.*|Net/ThemeName "Gruvbox-Material-Dark"|' ~/.xsettingsd
                killall -HUP xsettingsd
		sed -i --follow-symlinks 's/^@theme.*/@theme "gruvbox-material-dark"/' ~/.config/rofi/config.rasi
		sed -i --follow-symlinks 's|^dunst.*|dunst -conf ~/.config/dunst/dunstrc-gruvbox-material-dark \&|' ~/.config/qtile/autostart.sh
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
                sed -i --follow-symlinks 's|^colors.*|colors = colors.TokyoNight|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config
                sed -i --follow-symlinks 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/.config/alacritty/alacritty.toml
		sed -i --follow-symlinks 's|^include.*|include tokyo-night.conf|' ~/.config/kitty/kitty.conf
                kill -SIGUSR1 $(pgrep kitty)
                killall dunst
                dunst -conf ~/.config/dunst/dunstrc-tokyonight &
		sed -i 's|^Net/ThemeName.*|Net/ThemeName "Tokyonight-Dark"|' ~/.xsettingsd
                killall -HUP xsettingsd
		sed -i --follow-symlinks 's/^@theme.*/@theme "tokyonight"/' ~/.config/rofi/config.rasi
		sed -i --follow-symlinks 's|^dunst.*|dunst -conf ~/.config/dunst/dunstrc-tokyonight \&|' ~/.config/qtile/autostart.sh
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
