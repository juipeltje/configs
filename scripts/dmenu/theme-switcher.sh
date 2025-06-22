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

if [ -n "$WAYLAND_DISPLAY" ]; then
	theme=$( echo -e "${options[@]}" | fuzzel -d --width=14 --placeholder="Select a theme:" | awk '{print tolower($2)}' )
else
	theme=$( echo -e "${options[@]}" | rofi -dmenu -p "Select a theme:" -theme-str 'window {width: 300px;}' | awk '{print tolower($2)}' )
fi

# Variables
hostname=$( cat /etc/hostname )
COMMON_CONFIG_PATH=~/repos/configs/dotfiles/common/dotconfig
COMMON_NIX_CONFIG_PATH=~/repos/configs/nixos/machines/common/home-manager
WORKSTATION_CONFIG_PATH=~/repos/configs/dotfiles/workstation/dotconfig
LAPTOP_CONFIG_PATH=~/repos/configs/dotfiles/laptop/dotconfig

theme_switch() {
	# i3
	sed -i "s|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-${theme}.conf|" ${COMMON_CONFIG_PATH}/i3/common.conf

	# sway
        sed -i "s|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-${theme}.conf|" ${COMMON_CONFIG_PATH}/sway/common.conf

        # river
        sed -i "s|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-${theme}.sh|" ${COMMON_CONFIG_PATH}/river/common.sh

	# hyprland
	sed -i "s|^source=~/.config/hypr/colors.*|source=~/.config/hypr/colors-${theme}.conf|" ${COMMON_CONFIG_PATH}/hypr/common.conf

        # maomao
	sed -i "s|^source=~/.config/maomao/colors.*|source=~/.config/maomao/colors-${theme}.conf|" ${COMMON_CONFIG_PATH}/maomao/common.conf

        # alacritty
        sed -i "s|^import.*|import = [\"~/.config/alacritty/${theme}.toml\"]|" ${COMMON_CONFIG_PATH}/alacritty/alacritty.toml

	# foot
	sed -i "s|^include.*|include=~/.config/foot/${theme}.ini|" ${COMMON_CONFIG_PATH}/foot/foot.ini

        # kitty
        sed -i "s|^include.*|include ${theme}.conf|" ${COMMON_CONFIG_PATH}/kitty/kitty.conf

	if [ -n "$WAYLAND_DISPLAY" ]; then
        	# mako
        	sed -i "s|\${pkgs.mako}/bin/mako.*|\${pkgs.mako}/bin/mako -c \${config.home.homeDirectory}/.config/mako/${theme}-config\";|" ${COMMON_NIX_CONFIG_PATH}/wayland.nix
	else
		# dunst
        	sed -i "s|\${pkgs.dunst}/bin/dunst.*|\${pkgs.dunst}/bin/dunst -conf \${config.home.homeDirectory}/.config/dunst/dunstrc-${theme}\";|" ${COMMON_NIX_CONFIG_PATH}/x11.nix
	fi

        # waybar
        sed -i "s|^@import.*|@import \"${theme}.css\";|" ${COMMON_CONFIG_PATH}/waybar/style.css

        # fuzzel
        sed -i "s|^include.*|include=~/.config/fuzzel/${theme}.ini|" ${COMMON_CONFIG_PATH}/fuzzel/fuzzel.ini

	# rofi
        sed -i "s/^@theme.*/@theme \"${theme}\"/" ${COMMON_CONFIG_PATH}/rofi/config.rasi

        # gtklock
        sed -i "s|^@import.*|@import \"${theme}.css\";|" ${COMMON_CONFIG_PATH}/gtklock/style.css

        # tofi
        sed -i "s/^include = colors.*/include = colors-${theme}/" ${COMMON_CONFIG_PATH}/tofi/config
}

reload_programs() {
        # i3
        i3msg reload

        # sway
        swaymsg reload

        # river
        ~/.config/river/colors-${theme}.sh &

        # kitty
        kill -SIGUSR1 $(pgrep kitty)

        if [ -n "$WAYLAND_DISPLAY" ]; then
                # mako
                kill $(pgrep mako)
        	mako -c ~/.config/mako/${theme}-config &
        else
                # dunst
        	kill $(pgrep dunst)
        	dunst -conf ~/.config/dunst/dunstrc-${theme} &
        fi

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
                sed -i 's|^colors.*|colors = colors.Nord|' ${COMMON_CONFIG_PATH}/qtile/common.py

		# niri
                if [ "$hostname" = "NixOS-Rig" ]; then
		        sed -i 's|active-color.*|active-color "#d8dee9"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#434c5e"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		elif [ "$hostname" = "NixOS-Lappie" ]; then
			sed -i 's|active-color.*|active-color "#d8dee9"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#434c5e"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		fi

		# mwc
                if [ "$hostname" = "NixOS-Rig" ]; then
                        sed -i 's|active_border_color.*|active_border_color d8dee9ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 434c5eff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                elif [ "$hostname" = "NixOS-Lappie" ]; then
                        sed -i 's|active_border_color.*|active_border_color d8dee9ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 434c5eff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                fi

                # vscode
		sed -i 's/"workbench.colorTheme".*/"workbench.colorTheme" = "Nord";/' ${COMMON_NIX_CONFIG_PATH}/vscode.nix

                # GTK
                sed -i 's/theme.package.*/theme.package = pkgs.nordic;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Nordic";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix

                # home manager switch
                notify-send "Theme Switcher Script" "Done! Now running home manager switch..."
                home-manager switch --flake ~/repos/configs/nixos

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
                sed -i 's|^colors.*|colors = colors.GruvboxDark|' ${COMMON_CONFIG_PATH}/qtile/common.py

		# niri
                if [ "$hostname" = "NixOS-Rig" ]; then
		        sed -i 's|active-color.*|active-color "#ebdbb2"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#504945"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		elif [ "$hostname" = "NixOS-Lappie" ]; then
			sed -i 's|active-color.*|active-color "#ebdbb2"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#504945"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		fi

		# mwc
                if [ "$hostname" = "NixOS-Rig" ]; then
                        sed -i 's|active_border_color.*|active_border_color ebdbb2ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 504945ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                elif [ "$hostname" = "NixOS-Lappie" ]; then
                        sed -i 's|active_border_color.*|active_border_color ebdbb2ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 504945ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                fi

                # vscode
                sed -i 's/"workbench.colorTheme".*/"workbench.colorTheme" = "Gruvbox Dark Medium";/' ${COMMON_NIX_CONFIG_PATH}/vscode.nix

                # GTK
                sed -i 's/theme.package.*/theme.package = pkgs.gruvbox-gtk-theme;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Gruvbox-Dark";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix

                # home manager switch
                notify-send "Theme Switcher Script" "Done! Now running home manager switch..."
                home-manager switch --flake ~/repos/configs/nixos

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
                sed -i 's|^colors.*|colors = colors.Tokyonight|' ${COMMON_CONFIG_PATH}/qtile/common.py

		# niri
                if [ "$hostname" = "NixOS-Rig" ]; then
		        sed -i 's|active-color.*|active-color "#a9b1d6"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#414868"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		elif [ "$hostname" = "NixOS-Lappie" ]; then
			sed -i 's|active-color.*|active-color "#a9b1d6"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#414868"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		fi

		# mwc
                if [ "$hostname" = "NixOS-Rig" ]; then
                        sed -i 's|active_border_color.*|active_border_color a9b1d6ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 414868ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                elif [ "$hostname" = "NixOS-Lappie" ]; then
                        sed -i 's|active_border_color.*|active_border_color a9b1d6ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 414868ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                fi

                # vscode
                sed -i 's/"workbench.colorTheme".*/"workbench.colorTheme" = "Tokyo Night";/' ${COMMON_NIX_CONFIG_PATH}/vscode.nix

                # GTK
                sed -i 's/theme.package.*/theme.package = pkgs.tokyonight-gtk-theme;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Tokyonight-Dark";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix

                # home manager switch
                notify-send "Theme Switcher Script" "Done! Now running home manager switch..."
                home-manager switch --flake ~/repos/configs/nixos

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
                sed -i 's|^colors.*|colors = colors.SolarizedDark|' ${COMMON_CONFIG_PATH}/qtile/common.py

                # niri
                if [ "$hostname" = "NixOS-Rig" ]; then
		        sed -i 's|active-color.*|active-color "#93a1a1"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#073642"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		elif [ "$hostname" = "NixOS-Lappie" ]; then
			sed -i 's|active-color.*|active-color "#93a1a1"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#073642"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		fi

		# mwc
                if [ "$hostname" = "NixOS-Rig" ]; then
                        sed -i 's|active_border_color.*|active_border_color 93a1a1ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 073642ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                elif [ "$hostname" = "NixOS-Lappie" ]; then
                        sed -i 's|active_border_color.*|active_border_color 93a1a1ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 073642ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                fi

                # vscode
                sed -i 's/"workbench.colorTheme".*/"workbench.colorTheme" = "Solarized Dark";/' ${COMMON_NIX_CONFIG_PATH}/vscode.nix

                # GTK
                sed -i 's/theme.package.*/theme.package = pkgs.numix-solarized-gtk-theme;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "NumixSolarizedDarkGreen";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix

                # home manager switch
                notify-send "Theme Switcher Script" "Done! Now running home manager switch..."
                home-manager switch --flake ~/repos/configs/nixos

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
                sed -i 's|^colors.*|colors = colors.CatppuccinMocha|' ${COMMON_CONFIG_PATH}/qtile/common.py

                # niri
                if [ "$hostname" = "NixOS-Rig" ]; then
		        sed -i 's|active-color.*|active-color "#cdd6f4"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#45475a"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		elif [ "$hostname" = "NixOS-Lappie" ]; then
			sed -i 's|active-color.*|active-color "#cdd6f4"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#45475a"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		fi

		# mwc
                if [ "$hostname" = "NixOS-Rig" ]; then
                        sed -i 's|active_border_color.*|active_border_color cdd6f4ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 45475aff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                elif [ "$hostname" = "NixOS-Lappie" ]; then
                        sed -i 's|active_border_color.*|active_border_color cdd6f4ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 45475aff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                fi

                # vscode
                sed -i 's/"workbench.colorTheme".*/"workbench.colorTheme" = "Catppuccin Mocha";/' ${COMMON_NIX_CONFIG_PATH}/vscode.nix

                # GTK
                sed -i 's/theme.package.*/theme.package = pkgs.magnetic-catppuccin-gtk;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Catppuccin-GTK-Dark";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix

                # home manager switch
                notify-send "Theme Switcher Script" "Done! Now running home manager switch..."
                home-manager switch --flake ~/repos/configs/nixos

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
                sed -i 's|^colors.*|colors = colors.Dracula|' ${COMMON_CONFIG_PATH}/qtile/common.py

		# niri
                if [ "$hostname" = "NixOS-Rig" ]; then
		        sed -i 's|active-color.*|active-color "#f8f8f2"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#44475a"|' ${WORKSTATION_CONFIG_PATH}/niri/config.kdl
		elif [ "$hostname" = "NixOS-Lappie" ]; then
			sed -i 's|active-color.*|active-color "#f8f8f2"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		        sed -i 's|inactive-color.*|inactive-color "#44475a"|' ${LAPTOP_CONFIG_PATH}/niri/config.kdl
		fi

		# mwc
                if [ "$hostname" = "NixOS-Rig" ]; then
                        sed -i 's|active_border_color.*|active_border_color f8f8f2ff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 44475aff|' ${WORKSTATION_CONFIG_PATH}/mwc/mwc.conf
                elif [ "$hostname" = "NixOS-Lappie" ]; then
                        sed -i 's|active_border_color.*|active_border_color f8f8f2ff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                        sed -i 's|inactive_border_color.*|inactive_border_color 44475aff|' ${LAPTOP_CONFIG_PATH}/mwc/mwc.conf
                fi

                # vscode
		sed -i 's/"workbench.colorTheme".*/"workbench.colorTheme" = "Dracula Theme";/' ${COMMON_NIX_CONFIG_PATH}/vscode.nix

                # GTK
                sed -i 's/theme.package.*/theme.package = pkgs.dracula-theme;/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Dracula";/' ~/repos/configs/nixos/machines/common/home-manager/theming.nix

                # home manager switch
                notify-send "Theme Switcher Script" "Done! Now running home manager switch..."
                home-manager switch --flake ~/repos/configs/nixos

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
