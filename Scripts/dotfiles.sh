#!/bin/bash

# script for installing dotfiles from ssh git repo to the system

set -e

# Variables
color_reset="\033[0m"
green="\033[0;32m"
red="\033[0;31m"
bright_green="\033[0;92m"
PS3=$'\e[0;96m'"->"$'\e[m'

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
	sudo -u ${user} rm -rf /home/${user}/.bashrc
	sudo -u ${user} rm -rf /home/${user}/.bash_profile
	sudo -u ${user} rm -rf /home/${user}/.Xresources
	sudo -u ${user} rm -rf /home/${user}/.config/alacritty
	sudo -u ${user} rm -rf /home/${user}/.config/dunst
	sudo -u ${user} rm -rf /home/${user}/.config/git
	sudo -u ${user} rm -rf /home/${user}/.config/hypr
	sudo -u ${user} rm -rf /home/${user}/.config/i3
	sudo -u ${user} rm -rf /home/${user}/.config/mako
	sudo -u ${user} rm -rf /home/${user}/.config/mpv
	sudo -u ${user} rm -rf /home/${user}/.config/polybar
	sudo -u ${user} rm -rf /home/${user}/.config/qtile
	sudo -u ${user} rm -rf /home/${user}/.config/rofi
	sudo -u ${user} rm -rf /home/${user}/.config/sway
	sudo -u ${user} rm -rf /home/${user}/.config/waybar
	sudo -u ${user} rm -rf /home/${user}/.config/wofi
	sudo -u ${user} rm -rf /home/${user}/.config/yazi
}

configs() {
	sudo -u ${user} cp -f /home/${user}/configs/common/home/.Xresources /home/${user}/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/.bash_profile /home/${user}/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/.xinitrc-i3 /home/${user}/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/.xinitrc-qtile /home/${user}/
	sudo -u ${user} mkdir -p /home/${user}/.config
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/alacritty /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/dunst /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/git /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/hypr /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/i3 /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/mako /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/mpv /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/pipewire /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/rofi /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/sway /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/tofi /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/wofi /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/common/home/dotconfig/yazi /home/${user}/.config/
}

configs_desktop() {
	sudo -u ${user} cp -f /home/${user}/configs/workstation/home/.bashrc /home/${user}/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/hypr/* /home/${user}/.config/hypr/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/i3/* /home/${user}/.config/i3/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/polybar /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/qtile /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/sway/* /home/${user}/.config/sway/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/waybar /home/${user}/.config/
}

configs_laptop() {
	sudo -u ${user} cp -f /home/${user}/configs/laptop/home/.bashrc /home/${user}/
	sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/hypr/* /home/${user}/.config/hypr/
        sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/i3/* /home/${user}/.config/i3/
        sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/polybar /home/${user}/.config/
        sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/qtile /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/sway/* /home/${user}/.config/sway/
        sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/waybar /home/${user}/.config/
}

echo -e "${bright_green}This script will install dotfiles in the user's home folder using symlinks.
Confirm you understand this keeping in mind that something could go wrong and brick your system.${color_reset}"

select opt_1 in "${options_1[@]}"
do
	case ${opt_1} in
		"confirm")
                	echo -e "${bright_green}Continuing with post-install script...${color_reset}" 
		   	break
		   	;;
		"exit script")
			echo -e "${bright_green}Exiting post-install script...${color_reset}"
	           	exit 68
		   	;;
		*)
			echo -e "${red}Invalid option, please try again.${color_reset}"
			;;
	esac
done

echo -e "${bright_green}Please enter the username of your machine. this will be used as a variable in the install script.${color_reset}"

read user;

echo -e "${bright_green}Continuing post-install script as '${user}'...${color_reset}"

echo -e "${bright_green}One last question: are you using a desktop, laptop, or virtual machine?${color_reset}"

select opt_2 in "${options_2[@]}"
do
	case ${opt_2} in
		"desktop")
			echo -e "${bright_green}Continuing post-install script with settings for desktop${color_reset}"

			# Install config files
			echo -e "${bright_green}Installing config files...${color_reset}"
			rm_default_configs
			configs
			configs_desktop

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		"laptop")
			echo -e "${bright_green}Continuing post-install script with settings for laptop...${color_reset}"

			# Install config files
			echo -e "${bright_green}Installing config files...${color_reset}"
                        rm_default_configs
                        configs
			configs_laptop

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		"virtual machine")
			echo -e "${bright_green}Continuing post-install script with settings for virtual machine...${color_reset}"

			# Install config files
			echo -e "${bright_green}Installing config files...${color_reset}"
                        rm_default_configs
                        configs
                        configs_desktop

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		*)
			echo -e "${red}Invalid option, please try again.${color_reset}"
			;;
	esac
done
