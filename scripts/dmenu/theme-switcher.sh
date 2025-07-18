#!/usr/bin/env bash

# Theme switcher script
options=(
  "   Nord\n"
  "  Gruvbox-Dark\n"
  "  Tokyonight\n"
  "  Solarized-Dark\n"
  "  Catppuccin-Mocha\n"
  "  Dracula"
)

theme=$( echo -e "${options[@]}" | fuzzel -d --width=14 --placeholder="Select a theme:" | awk '{print tolower($2)}' )

# Functions
theme_switch() {
	# sway
        sed -i --follow-symlinks "s|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-${theme}.conf|" ~/.config/sway/common.conf

        # river
        sed -i --follow-symlinks "s|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-${theme}.sh|" ~/.config/river/common.sh

	# hyprland
	sed -i --follow-symlinks "s|^source=~/.config/hypr/colors.*|source=~/.config/hypr/colors-${theme}.conf|" ~/.config/hypr/common.conf

        # maomao
	sed -i --follow-symlinks "s|^source=~/.config/maomao/colors.*|source=~/.config/maomao/colors-${theme}.conf|" ~/.config/maomao/common.conf

        # alacritty
        sed -i --follow-symlinks "s|^import.*|import = [\"~/.config/alacritty/${theme}.toml\"]|" ~/.config/alacritty/alacritty.toml

	# foot
	sed -i --follow-symlinks "s|^include.*|include=~/.config/foot/${theme}.ini|" ~/.config/foot/foot.ini

        # kitty
        sed -i --follow-symlinks "s|^include.*|include ${theme}.conf|" ~/.config/kitty/kitty.conf

        # mako
        sed -i "s|^mako.*|mako -c ~/.config/mako/${theme}-config &|" ~/repos/configs/scripts/autostart/common-autostart.sh

        # waybar
        sed -i --follow-symlinks "s|^@import.*|@import \"${theme}.css\";|" ~/.config/waybar/style.css

        # fuzzel
        sed -i --follow-symlinks "s|^include.*|include=~/.config/fuzzel/${theme}.ini|" ~/.config/fuzzel/fuzzel.ini

        # gtklock
        sed -i --follow-symlinks "s|^@import.*|@import \"${theme}.css\";|" ~/.config/gtklock/style.css

        # tofi
        sed -i --follow-symlinks "s/^include = colors.*/include = colors-${theme}/" ~/.config/tofi/config
}

reload_programs() {
        # sway
        swaymsg reload

        # river
        ~/.config/river/colors-${theme}.sh &

        # kitty
        kill -SIGUSR1 $(pgrep kitty)

        # mako
        kill $(pgrep mako)
        mako -c ~/.config/mako/${theme}-config &

        # waybar
        kill -SIGUSR2 $(pgrep waybar)

        # qtile
        qtile cmd-obj -o cmd -f reload_config
}

case $theme in
	nord)
                # notify user that script is editing configs
                notify-send "Theme Switcher Script" "Editing configs..."

		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.Nord|' ~/.config/qtile/common.py

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#d8dee9"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#434c5e"|' ~/.config/niri/config.kdl

		# mwc
                sed -i --follow-symlinks 's|active_border_color.*|active_border_color d8dee9ff|' ~/.config/mwc/mwc.conf
                sed -i --follow-symlinks 's|inactive_border_color.*|inactive_border_color 434c5eff|' ~/.config/mwc/mwc.conf

                # vscode
		sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Nord"/' ~/.config/VSCodium/User/settings.json

                # GTK
		gsettings set org.gnome.desktop.interface gtk-theme Nordic

		# home manager
		sed -i 's/theme.package.*/theme.package = pkgs.nordic;/' ~/repos/configs/nix/machines/common/theming.nix
                sed -i 's/theme.name.*/theme.name = "Nordic";/' ~/repos/configs/nix/machines/common/theming.nix

                # reload programs
                notify-send "Theme Switcher Script" "Done! Now reloading programs..."
                reload_programs

		# foot
		for i in /dev/pts/*; do
                  if [ "$i" != "/dev/pts/ptmx" ]; then
		    printf '\e]10;#d8dee9\007' >> $i
		    printf '\e]11;#2e3440\007' >> $i
                    printf '\e]04;0;#3b4252\007' >> $i
		    printf '\e]04;1;#bf616a\007' >> $i
		    printf '\e]04;2;#a3be8c\007' >> $i
		    printf '\e]04;3;#ebcb8b\007' >> $i
		    printf '\e]04;4;#81a1c1\007' >> $i
		    printf '\e]04;5;#b48ead\007' >> $i
		    printf '\e]04;6;#88c0d0\007' >> $i
		    printf '\e]04;7;#e5e9f0\007' >> $i
		    printf '\e]04;8;#4c566a\007' >> $i
		    printf '\e]04;9;#bf616a\007' >> $i
		    printf '\e]04;10;#a3be8c\007' >> $i
		    printf '\e]04;11;#ebcb8b\007' >> $i
		    printf '\e]04;12;#81a1c1\007' >> $i
		    printf '\e]04;13;#b48ead\007' >> $i
		    printf '\e]04;14;#8fbcbb\007' >> $i
		    printf '\e]04;15;#eceff4\007' >> $i
                  fi
                done

		# done. notify user.
		notify-send "Theme Switcher Script" "Done! Current theme: Nord"
		;;
	gruvbox-dark)
                # notify user that script is editing configs
                notify-send "Theme Switcher Script" "Editing configs..."

		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.GruvboxDark|' ~/.config/qtile/common.py

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#ebdbb2"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#504945"|' ~/.config/niri/config.kdl

		# mwc
                sed -i --follow-symlinks 's|active_border_color.*|active_border_color ebdbb2ff|' ~/.config/mwc/mwc.conf
                sed -i --follow-symlinks 's|inactive_border_color.*|inactive_border_color 504945ff|' ~/.config/mwc/mwc.conf

                # vscode
                sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Gruvbox Dark Medium"/' ~/.config/VSCodium/User/settings.json

                # GTK
		gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Dark

		# home manager
		sed -i 's/theme.package.*/theme.package = pkgs.gruvbox-gtk-theme;/' ~/repos/configs/nix/machines/common/theming.nix
                sed -i 's/theme.name.*/theme.name = "Gruvbox-Dark";/' ~/repos/configs/nix/machines/common/theming.nix

                # reload programs
                notify-send "Theme Switcher Script" "Done! Now reloading programs..."
                reload_programs

		# foot
                for i in /dev/pts/*; do
                  if [ "$i" != "/dev/pts/ptmx" ]; then
                    printf '\e]10;#ebdbb2\007' >> $i
                    printf '\e]11;#282828\007' >> $i
                    printf '\e]04;0;#282828\007' >> $i
                    printf '\e]04;1;#cc241d\007' >> $i
                    printf '\e]04;2;#98971a\007' >> $i
                    printf '\e]04;3;#d79921\007' >> $i
                    printf '\e]04;4;#458588\007' >> $i
                    printf '\e]04;5;#b16286\007' >> $i
                    printf '\e]04;6;#689d6a\007' >> $i
                    printf '\e]04;7;#a89984\007' >> $i
                    printf '\e]04;8;#928374\007' >> $i
                    printf '\e]04;9;#fb4934\007' >> $i
                    printf '\e]04;10;#b8bb26\007' >> $i
                    printf '\e]04;11;#fabd2f\007' >> $i
                    printf '\e]04;12;#83a598\007' >> $i
                    printf '\e]04;13;#d3869b\007' >> $i
                    printf '\e]04;14;#8ec07c\007' >> $i
                    printf '\e]04;15;#ebdbb2\007' >> $i
                  fi
                done

		# done. notify user
		notify-send "Theme Switcher Script" "Done! Current theme: Gruvbox-Dark"
                ;;
	tokyonight)
                # notify user that script is editing configs
                notify-send "Theme Switcher Script" "Editing configs..."

		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.Tokyonight|' ~/.config/qtile/common.py

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#a9b1d6"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#414868"|' ~/.config/niri/config.kdl

		# mwc
                sed -i --follow-symlinks 's|active_border_color.*|active_border_color a9b1d6ff|' ~/.config/mwc/mwc.conf
                sed -i --follow-symlinks 's|inactive_border_color.*|inactive_border_color 414868ff|' ~/.config/mwc/mwc.conf

                # vscode
                sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Tokyo Night"/' ~/.config/VSCodium/User/settings.json

                # GTK
		gsettings set org.gnome.desktop.interface gtk-theme Tokyonight-Dark

		# home manager
		sed -i 's/theme.package.*/theme.package = pkgs.tokyonight-gtk-theme;/' ~/repos/configs/nix/machines/common/theming.nix
                sed -i 's/theme.name.*/theme.name = "Tokyonight-Dark";/' ~/repos/configs/nix/machines/common/theming.nix

                # reload programs
                notify-send "Theme Switcher Script" "Done! Now reloading programs..."
                reload_programs

		# foot
                for i in /dev/pts/*; do
                  if [ "$i" != "/dev/pts/ptmx" ]; then
                    printf '\e]10;#c0caf5\007' >> $i
                    printf '\e]11;#1a1b26\007' >> $i
                    printf '\e]04;0;#15161E\007' >> $i
                    printf '\e]04;1;#f7768e\007' >> $i
                    printf '\e]04;2;#9ece6a\007' >> $i
                    printf '\e]04;3;#e0af68\007' >> $i
                    printf '\e]04;4;#7aa2f7\007' >> $i
                    printf '\e]04;5;#bb9af7\007' >> $i
                    printf '\e]04;6;#7dcfff\007' >> $i
                    printf '\e]04;7;#a9b1d6\007' >> $i
                    printf '\e]04;8;#414868\007' >> $i
                    printf '\e]04;9;#f7768e\007' >> $i
                    printf '\e]04;10;#9ece6a\007' >> $i
                    printf '\e]04;11;#e0af68\007' >> $i
                    printf '\e]04;12;#7aa2f7\007' >> $i
                    printf '\e]04;13;#bb9af7\007' >> $i
                    printf '\e]04;14;#7dcfff\007' >> $i
                    printf '\e]04;15;#c0caf5\007' >> $i
                  fi
                done

		# done. notify user
		notify-send "Theme Switcher Script" "Done! Current theme: Tokyonight"
                ;;
	solarized-dark)
                # notify user that script is editing configs
                notify-send "Theme Switcher Script" "Editing configs..."

		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.SolarizedDark|' ~/.config/qtile/common.py

                # niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#93a1a1"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#073642"|' ~/.config/niri/config.kdl

		# mwc
                sed -i --follow-symlinks 's|active_border_color.*|active_border_color 93a1a1ff|' ~/.config/mwc/mwc.conf
                sed -i --follow-symlinks 's|inactive_border_color.*|inactive_border_color 073642ff|' ~/.config/mwc/mwc.conf

                # vscode
                sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Solarized Dark"/' ~/.config/VSCodium/User/settings.json

                # GTK
		gsettings set org.gnome.desktop.interface gtk-theme NumixSolarizedDarkGreen

		# home manager
		sed -i 's/theme.package.*/theme.package = pkgs.numix-solarized-gtk-theme;/' ~/repos/configs/nix/machines/common/theming.nix
                sed -i 's/theme.name.*/theme.name = "NumixSolarizedDarkGreen";/' ~/repos/configs/nix/machines/common/theming.nix

                # reload programs
                notify-send "Theme Switcher Script" "Done! Now reloading programs..."
                reload_programs

		# foot
                for i in /dev/pts/*; do
                  if [ "$i" != "/dev/pts/ptmx" ]; then
                    printf '\e]10;#839496\007' >> $i
                    printf '\e]11;#002b36\007' >> $i
                    printf '\e]04;0;#073642\007' >> $i
                    printf '\e]04;1;#dc322f\007' >> $i
                    printf '\e]04;2;#859900\007' >> $i
                    printf '\e]04;3;#b58900\007' >> $i
                    printf '\e]04;4;#268bd2\007' >> $i
                    printf '\e]04;5;#d33682\007' >> $i
                    printf '\e]04;6;#2aa198\007' >> $i
                    printf '\e]04;7;#eee8d5\007' >> $i
                    printf '\e]04;8;#002b36\007' >> $i
                    printf '\e]04;9;#cb4b16\007' >> $i
                    printf '\e]04;10;#586e75\007' >> $i
                    printf '\e]04;11;#657b83\007' >> $i
                    printf '\e]04;12;#839496\007' >> $i
                    printf '\e]04;13;#6c71c4\007' >> $i
                    printf '\e]04;14;#93a1a1\007' >> $i
                    printf '\e]04;15;#fdf6e3\007' >> $i
                  fi
                done

                # done. notify user
                notify-send "Theme Switcher Script" "Done! Current theme: Solarized-Dark"
		;;
	catppuccin-mocha)
                # notify user that script is editing configs
                notify-send "Theme Switcher Script" "Editing configs..."

                # execute function with variables
                theme_switch

                # qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.CatppuccinMocha|' ~/.config/qtile/common.py

                # niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#cdd6f4"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#45475a"|' ~/.config/niri/config.kdl

		# mwc
                sed -i --follow-symlinks 's|active_border_color.*|active_border_color cdd6f4ff|' ~/.config/mwc/mwc.conf
                sed -i --follow-symlinks 's|inactive_border_color.*|inactive_border_color 45475aff|' ~/.config/mwc/mwc.conf

                # vscode
                sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Catppuccin Mocha"/' ~/.config/VSCodium/User/settings.json

                # GTK
		gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Dark

		# home manager
		sed -i 's/theme.package.*/theme.package = pkgs.magnetic-catppuccin-gtk;/' ~/repos/configs/nix/machines/common/theming.nix
                sed -i 's/theme.name.*/theme.name = "Catppuccin-GTK-Dark";/' ~/repos/configs/nix/machines/common/theming.nix

                # reload programs
                notify-send "Theme Switcher Script" "Done! Now reloading programs..."
                reload_programs

		# foot
                for i in /dev/pts/*; do
                  if [ "$i" != "/dev/pts/ptmx" ]; then
                    printf '\e]10;#cdd6f4\007' >> $i
                    printf '\e]11;#1e1e2e\007' >> $i
                    printf '\e]04;0;#45475a\007' >> $i
                    printf '\e]04;1;#f38ba8\007' >> $i
                    printf '\e]04;2;#a6e3a1\007' >> $i
                    printf '\e]04;3;#f9e2af\007' >> $i
                    printf '\e]04;4;#89b4fa\007' >> $i
                    printf '\e]04;5;#f5c2e7\007' >> $i
                    printf '\e]04;6;#94e2d5\007' >> $i
                    printf '\e]04;7;#bac2de\007' >> $i
                    printf '\e]04;8;#585b70\007' >> $i
                    printf '\e]04;9;#f38ba8\007' >> $i
                    printf '\e]04;10;#a6e3a1\007' >> $i
                    printf '\e]04;11;#f9e2af\007' >> $i
                    printf '\e]04;12;#89b4fa\007' >> $i
                    printf '\e]04;13;#f5c2e7\007' >> $i
                    printf '\e]04;14;#94e2d5\007' >> $i
                    printf '\e]04;15;#a6adc8\007' >> $i
                  fi
                done

                # done. notify user
                notify-send "Theme Switcher Script" "Done! Current theme: Catppuccin-Mocha"
                ;;
        dracula)
                # notify user that script is editing configs
                notify-send "Theme Switcher Script" "Editing configs..."

		# execute function with variables
		theme_switch

		# qtile
                sed -i --follow-symlinks 's|^colors.*|colors = colors.Dracula|' ~/.config/qtile/common.py

		# niri
		sed -i --follow-symlinks 's|active-color.*|active-color "#f8f8f2"|' ~/.config/niri/config.kdl
		sed -i --follow-symlinks 's|inactive-color.*|inactive-color "#44475a"|' ~/.config/niri/config.kdl

		# mwc
                sed -i --follow-symlinks 's|active_border_color.*|active_border_color f8f8f2ff|' ~/.config/mwc/mwc.conf
                sed -i --follow-symlinks 's|inactive_border_color.*|inactive_border_color 44475aff|' ~/.config/mwc/mwc.conf

                # vscode
		sed -i --follow-symlinks 's/"workbench.colorTheme":.*/"workbench.colorTheme": "Dracula Theme"/' ~/.config/VSCodium/User/settings.json

                # GTK
		gsettings set org.gnome.desktop.interface gtk-theme Dracula

		# home manager
		sed -i 's/theme.package.*/theme.package = pkgs.dracula-theme;/' ~/repos/configs/nix/machines/common/theming.nix
                sed -i 's/theme.name.*/theme.name = "Dracula";/' ~/repos/configs/nix/machines/common/theming.nix

                # reload programs
                notify-send "Theme Switcher Script" "Done! Now reloading programs..."
                reload_programs

		# foot
		for i in /dev/pts/*; do
                  if [ "$i" != "/dev/pts/ptmx" ]; then
		    printf '\e]10;#f8f8f2\007' >> $i
		    printf '\e]11;#282a36\007' >> $i
                    printf '\e]04;0;#000000\007' >> $i
		    printf '\e]04;1;#ff5555\007' >> $i
		    printf '\e]04;2;#50fa7b\007' >> $i
		    printf '\e]04;3;#f1fa8c\007' >> $i
		    printf '\e]04;4;#bd93f9\007' >> $i
		    printf '\e]04;5;#ff79c6\007' >> $i
		    printf '\e]04;6;#8be9fd\007' >> $i
		    printf '\e]04;7;#bfbfbf\007' >> $i
		    printf '\e]04;8;#4d4d4d\007' >> $i
		    printf '\e]04;9;#ff6e67\007' >> $i
		    printf '\e]04;10;#5af78e\007' >> $i
		    printf '\e]04;11;#f4f99d\007' >> $i
		    printf '\e]04;12;#caa9fa\007' >> $i
		    printf '\e]04;13;#ff92d0\007' >> $i
		    printf '\e]04;14;#9aedfe\007' >> $i
		    printf '\e]04;15;#e6e6e6\007' >> $i
                  fi
                done

		# done. notify user.
		notify-send "Theme Switcher Script" "Done! Current theme: Dracula"
		;;
esac
