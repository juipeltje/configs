#!/usr/bin/env bash

# script for installing dotfiles from ssh git repo to the system

set -e

# Variables
color_reset="\033[0m"
green="\033[0;32m"
red="\033[0;31m"
bright_green="\033[0;92m"
PS3=$'\e[0;32m'"->"$'\e[m'
user=$USER

# Arrays
options_1=(
	"confirm"
	"exit script"
)

options_2=(
	"desktop"
	"laptop"
	"server"
	"virtual machine"
)

# Functions
rm_default_configs() {
	# Xorg-related configs, disabled for now.
	#rm -rf /home/${user}/.Xresources
	#rm -rf /home/${user}/.xinitrc-i3
	#rm -rf /home/${user}/.xinitrc-qtile
	#rm -rf /home/${user}/.config/dunst
	#rm -rf /home/${user}/.config/i3
	#rm -rf /home/${user}/.config/picom
	#rm -rf /home/${user}/.config/polybar
	#rm -rf /home/${user}/.config/rofi

	# remove default configs if present.
	rm -rf /home/${user}/.bashrc
	rm -rf /home/${user}/.bash_profile
	rm -rf /home/${user}/.config/alacritty
	rm -rf /home/${user}/.config/fastfetch
	rm -rf /home/${user}/.config/foot
	rm -rf /home/${user}/.config/fuzzel
	rm -rf /home/${user}/.config/git
	rm -f /home/${user}/.config/gtklock/*.css
	rm -rf /home/${user}/.config/helix
	rm -rf /home/${user}/.config/hypr
	rm -rf /home/${user}/.config/kanshi
	rm -rf /home/${user}/.config/kitty
	rm -rf /home/${user}/.config/mako
	rm -rf /home/${user}/.config/mango
	rm -rf /home/${user}/.config/mpd
	rm -rf /home/${user}/.config/mpv
	rm -rf /home/${user}/.config/mwc
	rm -rf /home/${user}/.config/nano
	rm -rf /home/${user}/.config/navidrome
	rm -rf /home/${user}/.config/niri
	rm -rf /home/${user}/.config/pipewire
	rm -rf /home/${user}/.config/qtile
	rm -rf /home/${user}/.config/river
	rm -rf /home/${user}/.config/sway
	rm -rf /home/${user}/.config/swayidle
	rm -rf /home/${user}/.config/tofi
	rm -f /home/${user}/.config/VSCodium/User/settings.json
	rm -rf /home/${user}/.config/waybar
	rm -rf /home/${user}/.config/yazi
	#rm -rf /home/${user}/.local/share/icons/default
}

make_directories() {
	# Xorg-related configs, disabled for now.
	#mkdir -p /home/${user}/.config/dunst
	#mkdir -p /home/${user}/.config/i3
	#mkdir -p /home/${user}/.config/picom
	#mkdir -p /home/${user}/.config/polybar
	#mkdir -p /home/${user}/.config/rofi

	# create directories for configs.
	mkdir -p /home/${user}/.config/alacritty
	mkdir -p /home/${user}/.config/fastfetch
	mkdir -p /home/${user}/.config/foot
	mkdir -p /home/${user}/.config/fuzzel
	mkdir -p /home/${user}/.config/git
	mkdir -p /home/${user}/.config/gtklock
	mkdir -p /home/${user}/.config/helix
	mkdir -p /home/${user}/.config/hypr
	mkdir -p /home/${user}/.config/kanshi
	mkdir -p /home/${user}/.config/kitty
	mkdir -p /home/${user}/.config/mako
	mkdir -p /home/${user}/.config/mango
	mkdir -p /home/${user}/.config/mpd
	mkdir -p /home/${user}/.config/mpv
	mkdir -p /home/${user}/.config/mwc
	mkdir -p /home/${user}/.config/nano
	mkdir -p /home/${user}/.config/niri
	mkdir -p /home/${user}/.config/pipewire
	mkdir -p /home/${user}/.config/qtile
	mkdir -p /home/${user}/.config/river
	mkdir -p /home/${user}/.config/sway
	mkdir -p /home/${user}/.config/swayidle
	mkdir -p /home/${user}/.config/tofi
	mkdir -p /home/${user}/.config/VSCodium/User
	mkdir -p /home/${user}/.config/waybar
	mkdir -p /home/${user}/.config/yazi
	#mkdir -p /home/${user}/.local/share/icons/default
}

configs() {
	# Xorg-related configs, disabled for now.
	#ln -s /home/${user}/repos/configs/dotfiles/common/.Xresources /home/${user}/
	#ln -s /home/${user}/repos/configs/dotfiles/common/.xinitrc-i3 /home/${user}/
	#ln -s /home/${user}/repos/configs/dotfiles/common/.xinitrc-qtile /home/${user}/
	#ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/dunst/* /home/${user}/.config/dunst/
	#ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/i3/* /home/${user}/.config/i3/
	#ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/picom/* /home/${user}/.config/picom/
	#ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/rofi/* /home/${user}/.config/rofi/

	# link common config files to their expected location.
	ln -s /home/${user}/repos/configs/dotfiles/common/.bashrc /home/${user}/
	ln -s /home/${user}/repos/configs/dotfiles/common/.bash_profile /home/${user}/
	mkdir -p /home/${user}/.config
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/alacritty/* /home/${user}/.config/alacritty/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/fastfetch/* /home/${user}/.config/fastfetch/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/foot/* /home/${user}/.config/foot/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/fuzzel/* /home/${user}/.config/fuzzel/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/git/* /home/${user}/.config/git/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/gtklock/* /home/${user}/.config/gtklock/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/helix/* /home/${user}/.config/helix/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/hypr/* /home/${user}/.config/hypr/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/kitty/* /home/${user}/.config/kitty/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/mako/* /home/${user}/.config/mako/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/mango/* /home/${user}/.config/mango/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/mpd/* /home/${user}/.config/mpd/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/mpv/* /home/${user}/.config/mpv/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/nano/* /home/${user}/.config/nano/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/pipewire/* /home/${user}/.config/pipewire/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/qtile/* /home/${user}/.config/qtile/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/river/* /home/${user}/.config/river/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/sway/* /home/${user}/.config/sway/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/tofi/* /home/${user}/.config/tofi/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/VSCodium/User/settings.json /home/${user}/.config/VSCodium/User/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/waybar/* /home/${user}/.config/waybar/
	ln -s /home/${user}/repos/configs/dotfiles/common/dotconfig/yazi/* /home/${user}/.config/yazi/
	#ln -s /home/${user}/repos/configs/common/home/dotlocal/share/icons/default/* /home/${user}/.local/share/icons/default/
}

configs_desktop() {
	# Xorg-related configs, disabled for now.
	#ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/i3/* /home/${user}/.config/i3/
	#ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/polybar/* /home/${user}/.config/polybar/

	# link desktop config files to their expected location.
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/hypr/* /home/${user}/.config/hypr/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/kanshi/* /home/${user}/.config/kanshi/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/mango/* /home/${user}/.config/mango/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/mwc/* /home/${user}/.config/mwc/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/niri/* /home/${user}/.config/niri/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/qtile/* /home/${user}/.config/qtile/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/river/* /home/${user}/.config/river/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/sway/* /home/${user}/.config/sway/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/swayidle/* /home/${user}/.config/swayidle/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/tofi/* /home/${user}/.config/tofi/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/waybar/* /home/${user}/.config/waybar/
}

configs_laptop() {
	# Xorg-related configs, disabled for now.
	#ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/i3/* /home/${user}/.config/i3/
	#ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/polybar/* /home/${user}/.config/polybar/

	# link laptop config files to their expected location.
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/hypr/* /home/${user}/.config/hypr/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/kanshi/* /home/${user}/.config/kanshi/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/mango/* /home/${user}/.config/mango/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/mwc/* /home/${user}/.config/mwc/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/niri/* /home/${user}/.config/niri/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/qtile/* /home/${user}/.config/qtile/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/river/* /home/${user}/.config/river/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/sway/* /home/${user}/.config/sway/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/swayidle/* /home/${user}/.config/swayidle/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/tofi/* /home/${user}/.config/tofi/
	ln -s /home/${user}/repos/configs/dotfiles/laptop/dotconfig/waybar/* /home/${user}/.config/waybar/
}

configs_server() {
	# link server config files to their expected location.
	# ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/hypr/* /home/${user}/.config/hypr/
	ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/kanshi/* /home/${user}/.config/kanshi/
	# ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/mango/* /home/${user}/.config/mango/
	# ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/mwc/* /home/${user}/.config/mwc/
	# ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/niri/* /home/${user}/.config/niri/
	# ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/qtile/* /home/${user}/.config/qtile/
	ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/river/* /home/${user}/.config/river/
	ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/sway/* /home/${user}/.config/sway/
	# ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/swayidle/* /home/${user}/.config/swayidle/
	# ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/tofi/* /home/${user}/.config/tofi/
	ln -s /home/${user}/repos/configs/dotfiles/workstation/dotconfig/waybar/* /home/${user}/.config/waybar/
	# ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/waybar/* /home/${user}/.config/waybar/

	# Navidrome
	mkdir -p /home/${user}/.config/navidrome
	ln -s /home/${user}/repos/configs/dotfiles/server/dotconfig/navidrome/* /home/${user}/.config/navidrome/
}

echo -e "${green}This script will install dotfiles in the user's home folder using symlinks (user: ${user}).
Confirm you understand this keeping in mind that something could go wrong and brick your system.${color_reset}"

select opt_1 in "${options_1[@]}"; do
	case ${opt_1} in
	"confirm")
		echo -e "${green}Continuing with install script...${color_reset}"
		break
		;;
	"exit script")
		echo -e "${green}Exiting install script...${color_reset}"
		exit 68
		;;
	*)
		echo -e "${red}Invalid option, please try again.${color_reset}"
		;;
	esac
done

echo -e "${green}One last question: are you using a desktop, laptop, server, or virtual machine?${color_reset}"

select opt_2 in "${options_2[@]}"; do
	case ${opt_2} in
	"desktop")
		echo -e "${green}Continuing install script with settings for desktop${color_reset}"

		# Install config files
		echo -e "${green}Installing config files...${color_reset}"
		rm_default_configs
		make_directories
		configs
		configs_desktop

		echo -e "${bright_green}Finished!! Enjoy your dots :)${color_reset}"
		exit 69
		;;
	"laptop")
		echo -e "${green}Continuing install script with settings for laptop...${color_reset}"

		# Install config files
		echo -e "${green}Installing config files...${color_reset}"
		rm_default_configs
		make_directories
		configs
		configs_laptop

		echo -e "${bright_green}Finished!! Enjoy your dots :)${color_reset}"
		exit 69
		;;
	"server")
		echo -e "${green}Continuing install script with settings for server...${color_reset}"

		# Install config files
		echo -e "${green}Installing config files...${color_reset}"
		rm_default_configs
		make_directories
		configs
		configs_server

		echo -e "${bright_green}Finished!! Enjoy your dots :)${color_reset}"
		exit 69
		;;
	"virtual machine")
		echo -e "${green}Continuing install script with settings for virtual machine...${color_reset}"

		# Install config files
		echo -e "${green}Installing config files...${color_reset}"
		rm_default_configs
		make_directories
		configs
		configs_desktop

		echo -e "${bright_green}Finished!! Enjoy your dots :)${color_reset}"
		exit 69
		;;
	*)
		echo -e "${red}Invalid option, please try again.${color_reset}"
		;;
	esac
done
