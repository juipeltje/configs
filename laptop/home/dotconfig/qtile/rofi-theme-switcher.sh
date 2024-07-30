#!/usr/bin/env bash

# Theme switcher script for Qtile

theme=$( echo -e "󰔎 Nordic\n󰔎 Gruvbox-Material-Dark\n󰔎 Tokyo-Night" | rofi -dmenu -p "Select a theme:" -theme-str 'window {width: 300px;}' | awk '{print $2}' )

case $theme in
	Nordic)
		sed -i 's|^colors.*|colors = colors.Nordic|' ~/repos/configs/common/home/dotconfig/qtile/common.py
		sed -i 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include nordic.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^@theme.*/@theme "nordic"/' ~/repos/configs/common/home/dotconfig/rofi/config.rasi
                sed -i 's|^dunst.*|dunst -conf ~/.config/dunst/dunstrc-nordic \&|' ~/repos/configs/laptop/home/dotconfig/qtile/autostart.sh
		kill $(pgrep dunst)
		sed -i 's/theme.package.*/theme.package = pkgs.nordic;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Nordic";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Lappie
		qtile cmd-obj -o cmd -f reload_config
		dunst -conf ~/.config/dunst/dunstrc-nordic &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
                sed -i 's|^colors.*|colors = colors.GruvboxMaterialDark|' ~/repos/configs/common/home/dotconfig/qtile/common.py
                sed -i 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include gruvbox-material-dark.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^@theme.*/@theme "gruvbox-material-dark"/' ~/repos/configs/common/home/dotconfig/rofi/config.rasi
                sed -i 's|^dunst.*|dunst -conf ~/.config/dunst/dunstrc-gruvbox-material-dark \&|' ~/repos/configs/laptop/home/dotconfig/qtile/autostart.sh
                kill $(pgrep dunst)
		sed -i 's/theme.package.*/theme.package = pkgs.gruvbox-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Gruvbox-Dark";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Lappie
		qtile cmd-obj -o cmd -f reload_config
		dunst -conf ~/.config/dunst/dunstrc-gruvbox-material-dark &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
                sed -i 's|^colors.*|colors = colors.TokyoNight|' ~/repos/configs/common/home/dotconfig/qtile/common.py
                sed -i 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include tokyo-night.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^@theme.*/@theme "tokyonight"/' ~/repos/configs/common/home/dotconfig/rofi/config.rasi
                sed -i 's|^dunst.*|dunst -conf ~/.config/dunst/dunstrc-tokyonight \&|' ~/repos/configs/laptop/home/dotconfig/qtile/autostart.sh
                kill $(pgrep dunst)
		sed -i 's/theme.package.*/theme.package = pkgs.tokyonight-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Tokyonight-Dark-BL";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Lappie
		qtile cmd-obj -o cmd -f reload_config
                dunst -conf ~/.config/dunst/dunstrc-tokyonight &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
