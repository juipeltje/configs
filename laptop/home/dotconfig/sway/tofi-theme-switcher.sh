#!/usr/bin/env bash

# Theme switcher script for SwayFX

theme=$( echo -e "󰔎 Nordic\n󰔎 Gruvbox-Material-Dark\n󰔎 Tokyo-Night" | tofi --width=300 --placeholder-text="Select a theme:" | awk '{print $2}' )

case $theme in
	Nordic)
		sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-nordic.conf|' ~/repos/configs/laptop/home/dotconfig/sway/config
		sed -i 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include nordic.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^include.*/include = nordic-colors/' ~/repos/configs/common/home/dotconfig/tofi/config
                sed -i 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/repos/configs/laptop/home/dotconfig/sway/autostart.sh
                sed -i 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-nordic.css \&|' ~/repos/configs/laptop/home/dotconfig/sway/autostart.sh
		kill $(pgrep mako)
		kill $(pgrep waybar)
		sed -i 's/theme.package.*/theme.package = pkgs.nordic;/' ~/repos/configs/nixos/common/home-manager/theming.nix
		sed -i 's/theme.name.*/theme.name = "Nordic";/' ~/repos/configs/nixos/common/home-manager/theming.nix
		home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Lappie
		swaymsg reload
		mako -c ~/.config/mako/nordic-config &
		waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-nordic.css &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
                sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-gruvbox-material-dark.conf|' ~/repos/configs/laptop/home/dotconfig/sway/config
                sed -i 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include gruvbox-material-dark.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^include.*/include = gruvbox-material-dark-colors/' ~/repos/configs/common/home/dotconfig/tofi/config
                sed -i 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/repos/configs/laptop/home/dotconfig/sway/autostart.sh
                sed -i 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-gruvbox-material-dark.css \&|' ~/repos/configs/laptop/home/dotconfig/sway/autostart.sh
		kill $(pgrep mako)
                kill $(pgrep waybar)
		sed -i 's/theme.package.*/theme.package = pkgs.gruvbox-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Gruvbox-Dark";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Lappie
		swaymsg reload
		mako -c ~/.config/mako/gruvbox-material-dark-config &
                waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-gruvbox-material-dark.css &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
                sed -i 's|^include ~/.config/sway/colors.*|include ~/.config/sway/colors-tokyonight.conf|' ~/repos/configs/laptop/home/dotconfig/sway/config
                sed -i 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include tokyo-night.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^include.*/include = tokyonight-colors/' ~/repos/configs/common/home/dotconfig/tofi/config
                sed -i 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/repos/configs/laptop/home/dotconfig/sway/autostart.sh
                sed -i 's|^waybar.*|waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-tokyonight.css \&|' ~/repos/configs/laptop/home/dotconfig/sway/autostart.sh
                kill $(pgrep mako)
                kill $(pgrep waybar)
		sed -i 's/theme.package.*/theme.package = pkgs.tokyonight-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Tokyonight-Dark-BL";/' ~/repos/configs/nixos/common/home-manager/theming.nix
		home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Lappie
		swaymsg reload
		mako -c ~/.config/mako/tokyonight-config &
                waybar -c ~/.config/waybar/sway-config -s ~/.config/waybar/sway-style-tokyonight.css &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
