#!/bin/bash

# Install script for aur helper + packages

set -e

# Variables
color_reset="\033[0m"
green="\033[0;32m"
red="\033[0;31m"
bright_cyan="\033[0;96m"
PS3=$'\e[0;96m'"->"$'\e[m'

# Arrays

aur_packages=(
	# Theming
        "phinger-cursors"
        "nordic-theme"
        "gruvbox-material-gtk-theme-git"
        "tokyonight-gtk-theme-git"
        "everforest-gtk-theme-git"
        "mint-y-icons"

        # Multimedia
        "deadbeef"
        "deadbeef-mpris2-plugin"
        "ueberzugpp"

        # SwayFX with autotiling
        "swayfx"
        "autotiling"

        # Gaming
        "bottles"
        "heroic-games-launcher-bin"
        "prismlauncher-bin"

        # Emulators
        "duckstation"
        "pcsx2-latest-bin"
        "rpcs3-bin"
        "vita3k-bin"

        # Benchmarking
        "unigine-heaven"
        "unigine-valley"
        "unigine-superposition"
)

options_1=(
	"1 - confirm"
        "2 - exit script"
)

# Functions

aur() {
	pacman -S --needed base-devel
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
        cd
        paru -S --noconfirm "${aur_packages[@]}"
}

echo -e "${bright_cyan}This script will install the paru aur helper and install a list of defined aur packages as your current user.
Confirm you understand this keeping in mind that something could go wrong and brick your system.
Installation will begin after confirming.${color_reset}"

select opt_1 in "${options_1[@]}"
do
	case ${opt_1} in
		"1 - confirm")
			echo -e "${bright_cyan}Starting installation of paru and aur packages...${color_reset}"
			aur
			echo -e "${green}Finished! paru and packages should now be installed on your system.${color_reset}"
			exit 69
			;;
		"2 - exit script")
			echo -e "${bright_cyan}Exiting...${color_reset}"
			exit 68
			;;
		*)
			echo -e "${red}Invalid option, please try again.${color_reset}"
			;;
	esac
done
