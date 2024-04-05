#!/usr/bin/env bash

# script for pulling my dotfiles in for nixos

set -e

# Functions

remove_defaults() {
	rm -rf /home/$user/.config/qtile
	rm -rf /home/$user/.config/rofi
	rm -rf /home/$user/.config/dunst
	rm -rf /home/$user/.config/picom
	rm -rf /home/$user/.config/hypr
	rm -rf /home/$user/.config/mako
	rm -rf /home/$user/.config/i3
	rm -rf /home/$user/.config/sway
	rm -rf /home/$user/.config/tofi
	rm -rf /home/$user/.config/polybar
	rm -rf /home/$user/.config/waybar
	rm -rf /home/$user/.config/mpv
	rm -rf /home/$user/.config/ranger
	rm -rf /home/$user/.config/wofi
	rm -rf /home/$user/.local/share/rofi
} 

configs_desktop() {
	mkdir -p /home/$user/.config
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/qtile /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/rofi /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/dunst /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/picom /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/hypr /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/mako /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/i3 /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/sway /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/tofi /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/polybar /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/waybar /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/mpv /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/ranger /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/wofi /home/$user/.config/
	mkdir -p /home/$user/.local/share
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotlocal/share/rofi /home/$user/.local/share/
}

configs_laptop() {
	mkdir -p /home/$user/.config
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/qtile /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/rofi /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/dunst /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/picom /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/hypr /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/mako /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/i3 /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/sway /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/tofi /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/polybar /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/waybar /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/mpv /home/$user/.config/
        ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/ranger /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/wofi /home/$user/.config/
	mkdir -p /home/$user/.local/share
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotlocal/share/rofi /home/$user/.local/share/
}

echo "This script will install dotfiles on the system. please confirm you have already made a git clone"
echo "of the repo before proceeding with this script."

echo "1) confirm"
echo "2) exit script"

while true; do
	read confirm_1;

	case $confirm_1 in
		1) echo "continuing with post-install script..." 
		   break
		   ;;
		2) echo "exiting post-install script..."
	           exit 68 
		   ;;
		*) echo "invalid input, please try again."
	esac
done

echo "please enter the username of your machine. this will be used as a variable in the install script"

read user;

echo "continuing post-install script as '$user'..."

echo "one last question: are you using a desktop, laptop, or virtual machine?"

echo "1) desktop"
echo "2) laptop"
echo "3) virtual machine"

read device;

echo "continuing post-install script with settings for '$device'"

if [ $device -eq 1 ]
then
	echo "removing default configs..."
	remove_defaults
	echo "installing config files..."
	configs_desktop
	echo "Finished!! Enjoy your dots :)"
elif [ $device -eq 2 ]
then
	echo "removing default configs..."
        remove_defaults
        echo "installing config files..."
        configs_laptop
        echo "Finished!! Enjoy your dots :)"
elif [ $device -eq 3 ]
then
	echo "removing default configs..."
        remove_defaults
        echo "installing config files..."
        configs_desktop
        echo "Finished!! Enjoy your dots :)"
else
	echo "device number not found, exiting..."
	exit 69
fi
