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

		# foot
		for i in $(pgrep bash); do
		  printf '\e]112\007' >> /proc/$i/fd/0
		  printf '\e]10;#d8dee9\007' >> /proc/$i/fd/0
		  printf '\e]11;#2e3440\007' >> /proc/$i/fd/0
                  printf '\e]04;0;#3b4252\007' >> /proc/$i/fd/0
		  printf '\e]04;1;#bf616a\007' >> /proc/$i/fd/0
		  printf '\e]04;2;#a3be8c\007' >> /proc/$i/fd/0
		  printf '\e]04;3;#ebcb8b\007' >> /proc/$i/fd/0
		  printf '\e]04;4;#81a1c1\007' >> /proc/$i/fd/0
		  printf '\e]04;5;#b48ead\007' >> /proc/$i/fd/0
		  printf '\e]04;6;#88c0d0\007' >> /proc/$i/fd/0
		  printf '\e]04;7;#e5e9f0\007' >> /proc/$i/fd/0
		  printf '\e]04;8;#4c566a\007' >> /proc/$i/fd/0
		  printf '\e]04;9;#bf616a\007' >> /proc/$i/fd/0
		  printf '\e]04;10;#a3be8c\007' >> /proc/$i/fd/0
		  printf '\e]04;11;#ebcb8b\007' >> /proc/$i/fd/0
		  printf '\e]04;12;#81a1c1\007' >> /proc/$i/fd/0
		  printf '\e]04;13;#b48ead\007' >> /proc/$i/fd/0
		  printf '\e]04;14;#8fbcbb\007' >> /proc/$i/fd/0
		  printf '\e]04;15;#eceff4\007' >> /proc/$i/fd/0
                done

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

		# foot
                for i in $(pgrep bash); do
                  printf '\e]112\007' >> /proc/$i/fd/0
                  printf '\e]10;#ebdbb2\007' >> /proc/$i/fd/0
                  printf '\e]11;#282828\007' >> /proc/$i/fd/0
                  printf '\e]04;0;#282828\007' >> /proc/$i/fd/0
                  printf '\e]04;1;#cc241d\007' >> /proc/$i/fd/0
                  printf '\e]04;2;#98971a\007' >> /proc/$i/fd/0
                  printf '\e]04;3;#d79921\007' >> /proc/$i/fd/0
                  printf '\e]04;4;#458588\007' >> /proc/$i/fd/0
                  printf '\e]04;5;#b16286\007' >> /proc/$i/fd/0
                  printf '\e]04;6;#689d6a\007' >> /proc/$i/fd/0
                  printf '\e]04;7;#a89984\007' >> /proc/$i/fd/0
                  printf '\e]04;8;#928374\007' >> /proc/$i/fd/0
                  printf '\e]04;9;#fb4934\007' >> /proc/$i/fd/0
                  printf '\e]04;10;#b8bb26\007' >> /proc/$i/fd/0
                  printf '\e]04;11;#fabd2f\007' >> /proc/$i/fd/0
                  printf '\e]04;12;#83a598\007' >> /proc/$i/fd/0
                  printf '\e]04;13;#d3869b\007' >> /proc/$i/fd/0
                  printf '\e]04;14;#8ec07c\007' >> /proc/$i/fd/0
                  printf '\e]04;15;#ebdbb2\007' >> /proc/$i/fd/0
                done

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

		# foot
                for i in $(pgrep bash); do
                  printf '\e]112\007' >> /proc/$i/fd/0
                  printf '\e]10;#c0caf5\007' >> /proc/$i/fd/0
                  printf '\e]11;#1a1b26\007' >> /proc/$i/fd/0
                  printf '\e]04;0;#15161E\007' >> /proc/$i/fd/0
                  printf '\e]04;1;#f7768e\007' >> /proc/$i/fd/0
                  printf '\e]04;2;#9ece6a\007' >> /proc/$i/fd/0
                  printf '\e]04;3;#e0af68\007' >> /proc/$i/fd/0
                  printf '\e]04;4;#7aa2f7\007' >> /proc/$i/fd/0
                  printf '\e]04;5;#bb9af7\007' >> /proc/$i/fd/0
                  printf '\e]04;6;#7dcfff\007' >> /proc/$i/fd/0
                  printf '\e]04;7;#a9b1d6\007' >> /proc/$i/fd/0
                  printf '\e]04;8;#414868\007' >> /proc/$i/fd/0
                  printf '\e]04;9;#f7768e\007' >> /proc/$i/fd/0
                  printf '\e]04;10;#9ece6a\007' >> /proc/$i/fd/0
                  printf '\e]04;11;#e0af68\007' >> /proc/$i/fd/0
                  printf '\e]04;12;#7aa2f7\007' >> /proc/$i/fd/0
                  printf '\e]04;13;#bb9af7\007' >> /proc/$i/fd/0
                  printf '\e]04;14;#7dcfff\007' >> /proc/$i/fd/0
                  printf '\e]04;15;#c0caf5\007' >> /proc/$i/fd/0
                done

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

		# foot
                for i in $(pgrep bash); do
                  printf '\e]112\007' >> /proc/$i/fd/0
                  printf '\e]10;#839496\007' >> /proc/$i/fd/0
                  printf '\e]11;#002b36\007' >> /proc/$i/fd/0
                  printf '\e]04;0;#073642\007' >> /proc/$i/fd/0
                  printf '\e]04;1;#dc322f\007' >> /proc/$i/fd/0
                  printf '\e]04;2;#859900\007' >> /proc/$i/fd/0
                  printf '\e]04;3;#b58900\007' >> /proc/$i/fd/0
                  printf '\e]04;4;#268bd2\007' >> /proc/$i/fd/0
                  printf '\e]04;5;#d33682\007' >> /proc/$i/fd/0
                  printf '\e]04;6;#2aa198\007' >> /proc/$i/fd/0
                  printf '\e]04;7;#eee8d5\007' >> /proc/$i/fd/0
                  printf '\e]04;8;#002b36\007' >> /proc/$i/fd/0
                  printf '\e]04;9;#cb4b16\007' >> /proc/$i/fd/0
                  printf '\e]04;10;#586e75\007' >> /proc/$i/fd/0
                  printf '\e]04;11;#657b83\007' >> /proc/$i/fd/0
                  printf '\e]04;12;#839496\007' >> /proc/$i/fd/0
                  printf '\e]04;13;#6c71c4\007' >> /proc/$i/fd/0
                  printf '\e]04;14;#93a1a1\007' >> /proc/$i/fd/0
                  printf '\e]04;15;#fdf6e3\007' >> /proc/$i/fd/0
                done

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

		# foot
                for i in $(pgrep bash); do
                  printf '\e]112\007' >> /proc/$i/fd/0
                  printf '\e]10;#cdd6f4\007' >> /proc/$i/fd/0
                  printf '\e]11;#1e1e2e\007' >> /proc/$i/fd/0
                  printf '\e]04;0;#45475a\007' >> /proc/$i/fd/0
                  printf '\e]04;1;#f38ba8\007' >> /proc/$i/fd/0
                  printf '\e]04;2;#a6e3a1\007' >> /proc/$i/fd/0
                  printf '\e]04;3;#f9e2af\007' >> /proc/$i/fd/0
                  printf '\e]04;4;#89b4fa\007' >> /proc/$i/fd/0
                  printf '\e]04;5;#f5c2e7\007' >> /proc/$i/fd/0
                  printf '\e]04;6;#94e2d5\007' >> /proc/$i/fd/0
                  printf '\e]04;7;#bac2de\007' >> /proc/$i/fd/0
                  printf '\e]04;8;#585b70\007' >> /proc/$i/fd/0
                  printf '\e]04;9;#f38ba8\007' >> /proc/$i/fd/0
                  printf '\e]04;10;#a6e3a1\007' >> /proc/$i/fd/0
                  printf '\e]04;11;#f9e2af\007' >> /proc/$i/fd/0
                  printf '\e]04;12;#89b4fa\007' >> /proc/$i/fd/0
                  printf '\e]04;13;#f5c2e7\007' >> /proc/$i/fd/0
                  printf '\e]04;14;#94e2d5\007' >> /proc/$i/fd/0
                  printf '\e]04;15;#a6adc8\007' >> /proc/$i/fd/0
		  printf '\e]19;#cdd6f4\007' >> /proc/$i/fd/0
		  printf '\e]17;#414356\007' >> /proc/$i/fd/0
                done

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
