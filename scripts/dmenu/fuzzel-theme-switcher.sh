#!/usr/bin/env bash

# Theme switcher script for Fuzzel

theme=$( echo -e "󰔎  Nordic\n󰔎  Gruvbox-Dark\n󰔎  Tokyonight\n󰔎  Solarized-Dark\n󰔎  Arc-Dark" | fuzzel -d --width=14 --placeholder="Select a theme:" | awk '{print tolower($2)}' )

theme_switch() {
	# sway
        sed -i --follow-symlinks "s|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-${theme}.conf|" ~/.config/sway/config
        swaymsg reload
        sed -i --follow-symlinks "s|^mako.*|mako -c ~/.config/mako/${theme}-config \&|" ~/.config/sway/autostart.sh

        # river
        sed -i --follow-symlinks "s|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-${theme}.sh|" ~/.config/river/common.sh
        ~/.config/river/colors-${theme}.sh &
        sed -i --follow-symlinks "s|^mako.*|mako -c ~/.config/mako/${theme}-config \&|" ~/.config/river/autostart.sh

        # qtile
        sed -i --follow-symlinks "s|^mako.*|mako -c ~/.config/mako/${theme}-config \&|" ~/.config/qtile/autostart-wayland.sh

        # niri
        sed -i --follow-symlinks "s|^mako.*|mako -c ~/.config/mako/${theme}-config \&|" ~/.config/niri/autostart.sh

        # alacritty
        sed -i --follow-symlinks "s|^import.*|import = [\"~/.config/alacritty/${theme}.toml\"]|" ~/.config/alacritty/alacritty.toml

        # kitty
        sed -i --follow-symlinks "s|^include.*|include ${theme}.conf|" ~/.config/kitty/kitty.conf
        kill -SIGUSR1 $(pgrep kitty)

        # mako
        killall mako
        mako -c ~/.config/mako/${theme}-config &

        # waybar
        sed -i --follow-symlinks "s|^@import.*|@import \"${theme}.css\";|" ~/.config/waybar/style.css
        killall -SIGUSR2 waybar

        # fuzzel
        sed -i --follow-symlinks "s|^include.*|include=~/.config/fuzzel/${theme}.ini|" ~/.config/fuzzel/fuzzel.ini

        # gtklock
        sed -i --follow-symlinks "s|^@import.*|@import \"${theme}.css\";|" ~/.config/gtklock/style.css

        # tofi
        sed -i --follow-symlinks "s/^include = colors.*/include = colors-${theme}/" ~/.config/tofi/config
}

case $theme in
	nordic)
		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.Nordic|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#8fbcbb"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#434c5e"|' ~/.config/niri/config.kdl

		# GTK
		gsettings set org.gnome.desktop.interface gtk-theme Nordic

		# done. notify user.
		notify-send "Theme Switcher Script" "Current theme: Nordic"
		;;
	gruvbox-dark)
		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.GruvboxDark|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#ebdbb2"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#504945"|' ~/.config/niri/config.kdl

		# GTK
		gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Material-Dark

		# done. notify user
		notify-send "Theme Switcher Script" "Current theme: Gruvbox-Dark"
                ;;
	tokyonight)
		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.Tokyonight|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#a9b1d6"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#24283b"|' ~/.config/niri/config.kdl

		# GTK
		gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark

		# done. notify user
		notify-send "Theme Switcher Script" "Current theme: Tokyonight"
                ;;
	solarized-dark)
		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.SolarizedDark|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

                # niri
                sed -i --follow-symlinks 's|active-color.*|active-color "#93a1a1"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#073642"|' ~/.config/niri/config.kdl

                # GTK
                gsettings set org.gnome.desktop.interface gtk-theme SolArc-Dark-solid

                # done. notify user
                notify-send "Theme Switcher Script" "Current theme: Solarized-Dark"
		;;
	arc-dark)
		# execute function with variables
                theme_switch

                # qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.ArcDark|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

                # niri
                sed -i --follow-symlinks 's|active-color.*|active-color "#5294e2"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#4b5162"|' ~/.config/niri/config.kdl

                # GTK
                gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark

                # done. notify user
                notify-send "Theme Switcher Script" "Current theme: Arc-Dark"
		;;
esac
