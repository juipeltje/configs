#!/usr/bin/env bash

# Theme switcher script for Rofi

theme=$( echo -e "󰔎 Nord\n󰔎 Gruvbox-Dark\n󰔎 Tokyonight\n󰔎  Solarized-Dark\n󰔎  Catppuccin-Mocha" | rofi -dmenu -p "Select a theme:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )

theme_switch() {
	# qtile
        sed -i --follow-symlinks "s|^dunst.*|dunst -conf ~/.config/dunst/dunstrc-${theme} \&|" ~/.config/qtile/autostart.sh

        # alacritty
        sed -i --follow-symlinks "s|^import.*|import = [\"~/.config/alacritty/${theme}.toml\"]|" ~/.config/alacritty/alacritty.toml

        # kitty
        sed -i --follow-symlinks "s|^include.*|include ${theme}.conf|" ~/.config/kitty/kitty.conf
        kill -SIGUSR1 $(pgrep kitty)

        # dunst
        killall dunst
        dunst -conf ~/.config/dunst/dunstrc-${theme} &

        # rofi
        sed -i --follow-symlinks "s/^@theme.*/@theme \"${theme}\"/" ~/.config/rofi/config.rasi
}

case $theme in
	nord)
		# execute function with variables
		theme_switch

		# qtile
		sed -i --follow-symlinks 's|^colors.*|colors = colors.Nord|' ~/.config/qtile/common.py
		qtile cmd-obj -o cmd -f reload_config

		# GTK
		sed -i 's|^Net/ThemeName.*|Net/ThemeName "Nordic"|' ~/.xsettingsd
		killall -HUP xsettingsd

		# done. notify user.
		notify-send "Theme Switcher Script" "Current theme: Nord"
		;;
	gruvbox-dark)
		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.GruvboxDark|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

		# GTK
		sed -i 's|^Net/ThemeName.*|Net/ThemeName "Gruvbox-Dark"|' ~/.xsettingsd
                killall -HUP xsettingsd

		# done. notify user.
		notify-send "Theme Switcher Script" "Current theme: Gruvbox-Dark"
                ;;
	tokyonight)
		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.Tokyonight|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

		# GTK
		sed -i 's|^Net/ThemeName.*|Net/ThemeName "Tokyonight-Dark"|' ~/.xsettingsd
                killall -HUP xsettingsd

		# done. notify user.
		notify-send "Theme Switcher Script" "Current theme: Tokyonight"
                ;;
	solarized-dark)
                # execute function with variables
                theme_switch

                # qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.SolarizedDark|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

                # GTK
                sed -i 's|^Net/ThemeName.*|Net/ThemeName "NumixSolarizedDarkGreen"|' ~/.xsettingsd
                killall -HUP xsettingsd

                # done. notify user.
                notify-send "Theme Switcher Script" "Current theme: Solarized-Dark"
                ;;
	catppuccin-mocha)
                # execute function with variables
                theme_switch

                # qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.CatppuccinMocha|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

                # GTK
                sed -i 's|^Net/ThemeName.*|Net/ThemeName "Catppuccin-Dark"|' ~/.xsettingsd
                killall -HUP xsettingsd

                # done. notify user.
                notify-send "Theme Switcher Script" "Current theme: Catppuccin-Mocha"
                ;;
esac
