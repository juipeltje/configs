#!/usr/bin/env bash

# script for installing dotfiles from ssh git repo to the system

set -e

# Variables
color_reset="\033[0m"
green="\033[0;32m"
red="\033[0;31m"
bright_green="\033[0;92m"
PS3=$'\e[0;32m'"->"$'\e[m'

# Arrays

options_1=(
	"confirm"
      	"exit script"
)

options_2=(
	"desktop"
	"laptop"
	"virtual machine"
)

# Functions

rm_default_configs() {
	rm -rf /home/${user}/.bashrc
	rm -rf /home/${user}/.bash_profile
	rm -rf /home/${user}/.profile
	rm -rf /home/${user}/.xinitrc-i3
	rm -rf /home/${user}/.xinitrc-qtile
	rm -rf /home/${user}/.Xresources
	rm -rf /home/${user}/.config/alacritty
	rm -rf /home/${user}/.config/dunst
	rm -rf /home/${user}/.config/fuzzel
	rm -rf /home/${user}/.config/git
	rm -rf /home/${user}/.config/gtklock
	rm -rf /home/${user}/.config/hypr
	rm -rf /home/${user}/.config/i3
	rm -rf /home/${user}/.config/kanshi
	rm -rf /home/${user}/.config/kitty
	rm -rf /home/${user}/.config/mako
	rm -rf /home/${user}/.config/mpd
	rm -rf /home/${user}/.config/mpv
	rm -rf /home/${user}/.config/nano
	rm -rf /home/${user}/.config/niri
	rm -rf /home/${user}/.config/picom
	rm -rf /home/${user}/.config/pipewire
	rm -rf /home/${user}/.config/polybar
	rm -rf /home/${user}/.config/qtile
	rm -rf /home/${user}/.config/river
	rm -rf /home/${user}/.config/rofi
	rm -rf /home/${user}/.config/sway
	rm -rf /home/${user}/.config/tofi
	rm -rf /home/${user}/.config/waybar
	rm -rf /home/${user}/.config/wofi
	rm -rf /home/${user}/.config/yazi
	rm -rf /home/${user}/.local/share/icons/default
}

make_directories() {
	mkdir -p /home/${user}/.config/alacritty
        mkdir -p /home/${user}/.config/dunst
	mkdir -p /home/${user}/.config/fuzzel
        mkdir -p /home/${user}/.config/git
	mkdir -p /home/${user}/.config/gtklock
        mkdir -p /home/${user}/.config/hypr
        mkdir -p /home/${user}/.config/i3
	mkdir -p /home/${user}/.config/kanshi
	mkdir -p /home/${user}/.config/kitty
        mkdir -p /home/${user}/.config/mako
	mkdir -p /home/${user}/.config/mpd
        mkdir -p /home/${user}/.config/mpv
	mkdir -p /home/${user}/.config/nano
	mkdir -p /home/${user}/.config/niri
	mkdir -p /home/${user}/.config/picom
	mkdir -p /home/${user}/.config/pipewire
        mkdir -p /home/${user}/.config/polybar
        mkdir -p /home/${user}/.config/qtile
	mkdir -p /home/${user}/.config/river
        mkdir -p /home/${user}/.config/rofi
        mkdir -p /home/${user}/.config/sway
	mkdir -p /home/${user}/.config/tofi
        mkdir -p /home/${user}/.config/waybar
        mkdir -p /home/${user}/.config/wofi
        mkdir -p /home/${user}/.config/yazi
	mkdir -p /home/${user}/.local/share/icons/default
}

configs() {
	ln -s /home/${user}/repos/configs/common/home/.Xresources /home/${user}/
	ln -s /home/${user}/repos/configs/common/home/.bash_profile /home/${user}/
	ln -s /home/${user}/repos/configs/common/home/.profile /home/${user}/
	ln -s /home/${user}/repos/configs/common/home/.xinitrc-i3 /home/${user}/
	ln -s /home/${user}/repos/configs/common/home/.xinitrc-qtile /home/${user}/
	mkdir -p /home/${user}/.config
	ln -s /home/${user}/repos/configs/common/home/dotconfig/alacritty/* /home/${user}/.config/alacritty/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/dunst/* /home/${user}/.config/dunst/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/fuzzel/* /home/${user}/.config/fuzzel/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/git/* /home/${user}/.config/git/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/gtklock/* /home/${user}/.config/gtklock/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/hypr/* /home/${user}/.config/hypr/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/i3/* /home/${user}/.config/i3/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/kitty/* /home/${user}/.config/kitty/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/mako/* /home/${user}/.config/mako/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/mpd/* /home/${user}/.config/mpd/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/mpv/* /home/${user}/.config/mpv/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/nano/* /home/${user}/.config/nano/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/picom/* /home/${user}/.config/picom/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/pipewire/* /home/${user}/.config/pipewire/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/qtile/* /home/${user}/.config/qtile/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/river/* /home/${user}/.config/river/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/rofi/* /home/${user}/.config/rofi/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/sway/* /home/${user}/.config/sway/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/tofi/* /home/${user}/.config/tofi/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/waybar/* /home/${user}/.config/waybar/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/wofi/* /home/${user}/.config/wofi/
	ln -s /home/${user}/repos/configs/common/home/dotconfig/yazi/* /home/${user}/.config/yazi/
	ln -s /home/${user}/repos/configs/common/home/dotlocal/share/icons/default/* /home/${user}/.local/share/icons/default/
}

configs_desktop() {
	ln -s /home/${user}/repos/configs/workstation/home/.bashrc /home/${user}/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/hypr/* /home/${user}/.config/hypr/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/i3/* /home/${user}/.config/i3/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/kanshi/* /home/${user}/.config/kanshi/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/niri/* /home/${user}/.config/niri/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/polybar/* /home/${user}/.config/polybar/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/qtile/* /home/${user}/.config/qtile/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/river/* /home/${user}/.config/river/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/sway/* /home/${user}/.config/sway/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/tofi/* /home/${user}/.config/tofi/
	ln -s /home/${user}/repos/configs/workstation/home/dotconfig/waybar/* /home/${user}/.config/waybar/
}

configs_laptop() {
	ln -s /home/${user}/repos/configs/laptop/home/.bashrc /home/${user}/
	ln -s /home/${user}/repos/configs/laptop/home/dotconfig/hypr/* /home/${user}/.config/hypr/
        ln -s /home/${user}/repos/configs/laptop/home/dotconfig/i3/* /home/${user}/.config/i3/
	ln -s /home/${user}/repos/configs/laptop/home/dotconfig/niri/* /home/${user}/.config/niri/
        ln -s /home/${user}/repos/configs/laptop/home/dotconfig/polybar/* /home/${user}/.config/polybar/
        ln -s /home/${user}/repos/configs/laptop/home/dotconfig/qtile/* /home/${user}/.config/qtile/
	ln -s /home/${user}/repos/configs/laptop/home/dotconfig/river/* /home/${user}/.config/river/
	ln -s /home/${user}/repos/configs/laptop/home/dotconfig/sway/* /home/${user}/.config/sway/
	ln -s /home/${user}/repos/configs/laptop/home/dotconfig/tofi/* /home/${user}/.config/tofi/
        ln -s /home/${user}/repos/configs/laptop/home/dotconfig/waybar/* /home/${user}/.config/waybar/
}

echo -e "${green}This script will install dotfiles in the user's home folder using symlinks.
Confirm you understand this keeping in mind that something could go wrong and brick your system.${color_reset}"

select opt_1 in "${options_1[@]}"
do
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

echo -e "${green}Please enter the username of your machine. this will be used as a variable in the install script.${color_reset}"

read user;

echo -e "${green}Continuing install script as '${user}'...${color_reset}"

echo -e "${green}One last question: are you using a desktop, laptop, or virtual machine?${color_reset}"

select opt_2 in "${options_2[@]}"
do
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
