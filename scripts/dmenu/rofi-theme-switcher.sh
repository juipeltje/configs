#!/usr/bin/env bash

# Theme switcher script for Rofi

theme=$( echo -e "󰔎 Nordic\n󰔎 Gruvbox-Dark\n󰔎 Tokyonight\n󰔎  Solarized-Dark\n󰔎  Arc-Dark" | rofi -dmenu -p "Select a theme:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )

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
	nordic)
		# execute function with variables
		theme_switch

		# qtile
		sed -i --follow-symlinks 's|^colors.*|colors = colors.Nordic|' ~/.config/qtile/common.py
		qtile cmd-obj -o cmd -f reload_config

		# GTK
		sed -i 's|^Net/ThemeName.*|Net/ThemeName "Nordic"|' ~/.xsettingsd
		killall -HUP xsettingsd

		# done. notify user.
		notify-send "Theme Switcher Script" "Current theme: Nordic"
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
	arc-dark)
                # execute function with variables
                theme_switch

                # qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.ArcDark|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

                # GTK
                sed -i 's|^Net/ThemeName.*|Net/ThemeName "Arc-Dark"|' ~/.xsettingsd
                killall -HUP xsettingsd

                # done. notify user.
                notify-send "Theme Switcher Script" "Current theme: Arc-Dark"
                ;;
esac
