#!/usr/bin/env bash

# Theme switcher script for River

theme=$( echo -e "󰔎 Nordic\n󰔎 Gruvbox-Material-Dark\n󰔎 Tokyo-Night" | tofi --width=300 --placeholder-text="Select a theme:" | awk '{print $2}' )

case $theme in
	Nordic)
		sed -i 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-nordic.sh|' ~/repos/configs/common/home/dotconfig/river/common.sh
		sed -i 's|^import.*|import = ["~/.config/alacritty/nordic.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include nordic.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^include.*/include = nordic-colors/' ~/repos/configs/common/home/dotconfig/tofi/config
                sed -i 's|^mako.*|mako -c ~/.config/mako/nordic-config \&|' ~/repos/configs/workstation/home/dotconfig/river/autostart.sh
                sed -i 's|^waybar.*|waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-nordic.css \&|' ~/repos/configs/workstation/home/dotconfig/river/autostart.sh
		kill $(pgrep mako)
		kill $(pgrep waybar)
		sed -i 's/theme.package.*/theme.package = pkgs.nordic;/' ~/repos/configs/nixos/common/home-manager/theming.nix
		sed -i 's/theme.name.*/theme.name = "Nordic";/' ~/repos/configs/nixos/common/home-manager/theming.nix
		home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Rig --extra-experimental-features "nix-command flakes"
		~/.config/river/colors-nordic.sh &
		mako -c ~/.config/mako/nordic-config &
		waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-nordic.css &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Nordic"
		;;
	Gruvbox-Material-Dark)
                sed -i 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-gruvbox-material-dark.sh|' ~/repos/configs/common/home/dotconfig/river/common.sh
                sed -i 's|^import.*|import = ["~/.config/alacritty/gruvbox-material-dark.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include gruvbox-material-dark.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^include.*/include = gruvbox-material-dark-colors/' ~/repos/configs/common/home/dotconfig/tofi/config
                sed -i 's|^mako.*|mako -c ~/.config/mako/gruvbox-material-dark-config \&|' ~/repos/configs/workstation/home/dotconfig/river/autostart.sh
                sed -i 's|^waybar.*|waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-gruvbox-material-dark.css \&|' ~/repos/configs/workstation/home/dotconfig/river/autostart.sh
		kill $(pgrep mako)
                kill $(pgrep waybar)
		sed -i 's/theme.package.*/theme.package = pkgs.gruvbox-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Gruvbox-Dark";/' ~/repos/configs/nixos/common/home-manager/theming.nix
                home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Rig --extra-experimental-features "nix-command flakes"
		~/.config/river/colors-gruvbox-material-dark.sh &
		mako -c ~/.config/mako/gruvbox-material-dark-config &
                waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-gruvbox-material-dark.css &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Gruvbox-Material-Dark"
                ;;
	Tokyo-Night)
                sed -i 's|^riverctl spawn ~/.config/river/colors.*|riverctl spawn ~/.config/river/colors-tokyonight.sh|' ~/repos/configs/common/home/dotconfig/river/common.sh
                sed -i 's|^import.*|import = ["~/.config/alacritty/tokyo-night.toml"]|' ~/repos/configs/common/home/dotconfig/alacritty/alacritty.toml
		sed -i 's|^include.*|include tokyo-night.conf|' ~/repos/configs/common/home/dotconfig/kitty/kitty.conf
		sed -i 's/^include.*/include = tokyonight-colors/' ~/repos/configs/common/home/dotconfig/tofi/config
                sed -i 's|^mako.*|mako -c ~/.config/mako/tokyonight-config \&|' ~/repos/configs/workstation/home/dotconfig/river/autostart.sh
                sed -i 's|^waybar.*|waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-tokyonight.css \&|' ~/repos/configs/workstation/home/dotconfig/river/autostart.sh
                kill $(pgrep mako)
                kill $(pgrep waybar)
		sed -i 's/theme.package.*/theme.package = pkgs.tokyonight-gtk-theme;/' ~/repos/configs/nixos/common/home-manager/theming.nix
                sed -i 's/theme.name.*/theme.name = "Tokyonight-Dark-BL";/' ~/repos/configs/nixos/common/home-manager/theming.nix
		home-manager switch --flake ~/repos/configs/nixos#joppe@NixOS-Rig --extra-experimental-features "nix-command flakes"
		~/.config/river/colors-tokyonight.sh &
		mako -c ~/.config/mako/tokyonight-config &
                waybar -c ~/.config/waybar/river-config -s ~/.config/waybar/river-style-tokyonight.css &
		kill -SIGUSR1 $(pgrep kitty)
		notify-send "Current theme: Tokyo-Night"
                ;;
esac
