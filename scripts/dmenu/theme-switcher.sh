#!/usr/bin/env bash

# Theme switcher script
if [ -n "$WAYLAND_DISPLAY" ]; then
	theme=$( echo -e "  Nord\n  Gruvbox-Dark\n  Tokyonight\n  Solarized-Dark\n  Catppuccin-Mocha" | fuzzel -d --width=14 --placeholder="Select a theme:" | awk '{print tolower($2)}' )
else
	theme=$( echo -e " Nord\n Gruvbox-Dark\n Tokyonight\n  Solarized-Dark\n  Catppuccin-Mocha" | rofi -dmenu -p "Select a theme:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )
fi

theme_switch() {
	# i3
	sed -i --follow-symlinks "s|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-${theme}.conf|" ~/.config/i3/common.conf
        i3msg reload

	# sway
        sed -i --follow-symlinks "s|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-${theme}.conf|" ~/.config/sway/common.conf
        swaymsg reload

        # river
        sed -i --follow-symlinks "s|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-${theme}.sh|" ~/.config/river/common.sh
        ~/.config/river/colors-${theme}.sh &

	# hyprland
	sed -i --follow-symlinks "s|^source=~/.config/hypr/colors.*|source=~/.config/hypr/colors-${theme}.conf|" ~/.config/hypr/common.conf

        # alacritty
        sed -i --follow-symlinks "s|^import.*|import = [\"~/.config/alacritty/${theme}.toml\"]|" ~/.config/alacritty/alacritty.toml

	# foot
	sed -i --follow-symlinks "s|^include.*|include=~/.config/foot/${theme}.ini|" ~/.config/foot/foot.ini

        # kitty
        sed -i --follow-symlinks "s|^include.*|include ${theme}.conf|" ~/.config/kitty/kitty.conf
        kill -SIGUSR1 $(pgrep kitty)

	if [ -n "$WAYLAND_DISPLAY" ]; then
        	# mako
        	kill $(pgrep mako)
        	mako -c ~/.config/mako/${theme}-config &
        	sed -i --follow-symlinks "s|\${pkgs.mako}/bin/mako.*|\${pkgs.mako}/bin/mako -c \${config.home.homeDirectory}/.config/mako/${theme}-config\";|" ~/repos/configs/nixos/machines/common/home-manager/wayland.nix
	else
		# dunst
        	kill $(pgrep dunst)
        	dunst -conf ~/.config/dunst/dunstrc-${theme} &
        	sed -i --follow-symlinks "s|\${pkgs.dunst}/bin/dunst.*|\${pkgs.dunst}/bin/dunst -conf \${config.home.homeDirectory}/.config/dunst/dunstrc-${theme}\";|" ~/repos/configs/nixos/machines/common/home-manager/x11.nix
	fi

        # waybar
        sed -i --follow-symlinks "s|^@import.*|@import \"${theme}.css\";|" ~/.config/waybar/style.css
        kill -SIGUSR2 $(pgrep waybar)

        # fuzzel
        sed -i --follow-symlinks "s|^include.*|include=~/.config/fuzzel/${theme}.ini|" ~/.config/fuzzel/fuzzel.ini

	# rofi
        sed -i --follow-symlinks "s/^@theme.*/@theme \"${theme}\"/" ~/.config/rofi/config.rasi

        # gtklock
        sed -i --follow-symlinks "s|^@import.*|@import \"${theme}.css\";|" ~/.config/gtklock/style.css

        # tofi
        sed -i --follow-symlinks "s/^include = colors.*/include = colors-${theme}/" ~/.config/tofi/config
}

case $theme in
	nord)
		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.Nord|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#d8dee9"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#434c5e"|' ~/.config/niri/config.kdl

		# GTK
		#gsettings set org.gnome.desktop.interface gtk-theme Nordic
		#sed -i 's|^Net/ThemeName.*|Net/ThemeName "Nordic"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# vscode
		sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Nord"/' ~/.config/VSCodium/User/settings.json

		# done with configs, now setting gtk theme with home manager
		notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

		# home manager
 		sed -i 's/theme.package.*/theme.package = pkgs.nordic;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Nordic";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

		# done. notify user.
		notify-send "Theme Switcher Script" "Current theme: Nord"
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
		#gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Dark
		#sed -i 's|^Net/ThemeName.*|Net/ThemeName "Gruvbox-Dark"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# vscode
                sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Gruvbox Dark Medium"/' ~/.config/VSCodium/User/settings.json

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
		sed -i 's/theme.package.*/theme.package = pkgs.gruvbox-gtk-theme;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Gruvbox-Dark";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

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
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#414868"|' ~/.config/niri/config.kdl

		# GTK
		#gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark
		#sed -i 's|^Net/ThemeName.*|Net/ThemeName "Tokyonight-Dark"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# vscode
                sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Tokyo Night"/' ~/.config/VSCodium/User/settings.json

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
		sed -i 's/theme.package.*/theme.package = pkgs.tokyonight-gtk-theme;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Tokyonight-Dark";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

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
                #gsettings set org.gnome.desktop.interface gtk-theme NumixSolarizedDarkGreen
		#sed -i 's|^Net/ThemeName.*|Net/ThemeName "NumixSolarizedDarkGreen"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# vscode
                sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Solarized Dark"/' ~/.config/VSCodium/User/settings.json

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
                sed -i 's/theme.package.*/theme.package = pkgs.numix-solarized-gtk-theme;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "NumixSolarizedDarkGreen";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

                # done. notify user
                notify-send "Theme Switcher Script" "Current theme: Solarized-Dark"
		;;
	catppuccin-mocha)
                # execute function with variables
                theme_switch

                # qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.CatppuccinMocha|' ~/.config/qtile/common.py
                qtile cmd-obj -o cmd -f reload_config

                # niri
                sed -i --follow-symlinks 's|active-color.*|active-color "#cdd6f4"|' ~/.config/niri/config.kdl
                sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#45475a"|' ~/.config/niri/config.kdl

                # GTK
                #gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Dark
		#sed -i 's|^Net/ThemeName.*|Net/ThemeName "Catppuccin-Dark"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# vscode
                sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Catppuccin Mocha"/' ~/.config/VSCodium/User/settings.json

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
                sed -i 's/theme.package.*/theme.package = pkgs.magnetic-catppuccin-gtk;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Catppuccin-GTK-Dark";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

                # done. notify user
                notify-send "Theme Switcher Script" "Current theme: Catppuccin-Mocha"
                ;;
esac
