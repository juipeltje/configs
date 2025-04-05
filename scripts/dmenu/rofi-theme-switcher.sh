#!/usr/bin/env bash

# Theme switcher script for Rofi

theme=$( echo -e "󰔎 Nord\n󰔎 Gruvbox-Dark\n󰔎 Tokyonight\n󰔎  Solarized-Dark\n󰔎  Catppuccin-Mocha" | rofi -dmenu -p "Select a theme:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )

theme_switch() {
        # alacritty
        sed -i --follow-symlinks "s|^import.*|import = [\"~/.config/alacritty/${theme}.toml\"]|" ~/.config/alacritty/alacritty.toml

        # kitty
        sed -i --follow-symlinks "s|^include.*|include ${theme}.conf|" ~/.config/kitty/kitty.conf
        kill -SIGUSR1 $(pgrep kitty)

        # dunst
        kill $(pgrep dunst)
        dunst -conf ~/.config/dunst/dunstrc-${theme} &
	sed -i --follow-symlinks "s|\${pkgs.dunst}/bin/dunst.*|\${pkgs.dunst}/bin/dunst -conf \${config.home.homeDirectory}/.config/dunst/dunstrc-${theme}\";|" ~/repos/configs/nixos/common/home-manager/x11.nix

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
		#sed -i 's|^Net/ThemeName.*|Net/ThemeName "Nordic"|' ~/.xsettingsd
		#killall -HUP xsettingsd

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
                sed -i 's/theme.package.*/theme.package = pkgs.nordic;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Nordic";/' ~/repos/configs/nixos/common/home-manager/theming.nix
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

		# GTK
		#sed -i 's|^Net/ThemeName.*|Net/ThemeName "Gruvbox-Dark"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
                sed -i 's/theme.package.*/theme.package = pkgs.gruvbox-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Gruvbox-Dark";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

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
		#sed -i 's|^Net/ThemeName.*|Net/ThemeName "Tokyonight-Dark"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
                sed -i 's/theme.package.*/theme.package = pkgs.tokyonight-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Tokyonight-Dark";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

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
                #sed -i 's|^Net/ThemeName.*|Net/ThemeName "NumixSolarizedDarkGreen"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
                sed -i 's/theme.package.*/theme.package = pkgs.numix-solarized-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "NumixSolarizedDarkGreen";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

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
                #sed -i 's|^Net/ThemeName.*|Net/ThemeName "Catppuccin-Dark"|' ~/.xsettingsd
                #killall -HUP xsettingsd

		# done with configs, now setting gtk theme with home manager
                notify-send "Theme Switcher Script" "switching gtk theme with home manager..."

                # home manager
                sed -i 's/theme.package.*/theme.package = pkgs.magnetic-catppuccin-gtk;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Catppuccin-GTK-Dark";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos

                # done. notify user.
                notify-send "Theme Switcher Script" "Current theme: Catppuccin-Mocha"
                ;;
esac
