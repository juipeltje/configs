#!/bin/bash

# script for pulling my dotfiles in for nixos
# NOTE TO SELF: MAKE SURE TO SETUP YOUR SSH KEY AND IT'S PERMISSIONS TO 400 BEFORE RUNNING THIS SCRIPT!!

set -e

# Functions

configs() {
	git clone git@github.com:juipeltje/configs.git /home/$user/repos/configs
        rm /home/$user/.bashrc
        ln -s /home/$user/repos/configs/dotfiles/.bashrc /home/$user/
	ln -s /home/$user/repos/configs/dotfiles/.bash_profile /home/$user/
	ln -s /home/$user/repos/configs/dotfiles/.xinitrc-i3 /home/$user/
	ln -s /home/$user/repos/configs/dotfiles/.xinitrc-qtile /home/$user/
}

configs_desktop() {
	ln -s /home/$user/repos/configs/workstation/dotfiles/.Xresources /home/$user
	mkdir -p /home/$user/.config
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/qtile /home/$user/.config/
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/alacritty /home/$user/.config/
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
	mkdir -p /home/$user/.local/share
	ln -s /home/$user/repos/configs/workstation/dotfiles/dotlocal/share/rofi /home/$user/.local/share/
}

configs_laptop() {
	ln -s /home/$user/repos/configs/laptop/dotfiles/.Xresources /home/$user
	mkdir -p /home/$user/.config
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/qtile /home/$user/.config/
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/alacritty /home/$user/.config/
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
	mkdir -p /home/$user/.local/share
	ln -s /home/$user/repos/configs/laptop/dotfiles/dotlocal/share/rofi /home/$user/.local/share/
}

echo "This script will use a git ssh clone to install dotfiles on the system. please confirm you have setup your git account"
echo "and ssh key before proceeding with the script."

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
	echo "installing config files..."
	configs
	configs_desktop
	echo "Finished!! Enjoy your dots :)"
elif [ $device -eq 2 ]
then
        echo "installing config files..."
        configs
        configs_laptop
        echo "Finished!! Enjoy your dots :)"
elif [ $device -eq 3 ]
then
        echo "installing config files..."
        configs
        configs_desktop
        echo "Finished!! Enjoy your dots :)"
else
	echo "device number not found, exiting..."
	exit 69
fi
