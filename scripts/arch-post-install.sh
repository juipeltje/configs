#!/bin/bash

# post install script for arch linux

set -e

# Variables
color_reset="\033[0m"
green="\033[0;32m"
red="\033[0;31m"
bright_cyan="\033[0;96m"
PS3=$'\e[0;96m'"->"$'\e[m'

# Arrays

packages=(
        # Xorg/Window managers
        "xorg-server"
        "xorg-xinit"
        "xf86-video-amdgpu"
        "xdotool"
        "i3-wm"
        "qtile"

        # Wayland/Compositors
        "hyprland"
        "hyprpaper"
        "xorg-xwayland"

        # Greeter
        "greetd"
        "greetd-regreet"

        # Gaming
        "vulkan-icd-loader"
        "lib32-vulkan-icd-loader"
        "vulkan-radeon"
        "lib32-vulkan-radeon"
        "lib32-mesa"
        "libva-mesa-driver"
        "lib32-libva-mesa-driver"
        "mesa-vdpau"
        "lib32-mesa-vdpau"
	"corectrl"
        "steam"
        "gamemode"
        "lib32-gamemode"
        "mangohud"
        "lib32-mangohud"
        "dolphin-emu"

        # Networking
        "network-manager-applet"
        "openssh"
        "transmission-gtk"

        # Bluetooth
        "bluez"
        "blueman"

        # Terminal
        "alacritty"

        # Webbrowser
        "firefox"

        # File managers/utilities
        "pcmanfm-gtk3"
        "yazi"
        "unzip"
        "p7zip"
        "gvfs"
        "fuse2"

        # E-mail
        "thunderbird"

        # Notifications
        "dunst"
        "mako"
        "libnotify"

        # Run launchers
        "rofi"
        "wofi"

        # Status bars
        "polybar"
        "waybar"

        # Multimedia
        "alsa-utils"
        "pavucontrol"
        "playerctl"
        "mpv"
	"kodi"
        "feh"

        # Fetch tools
        "fastfetch"

        # Theming/Fonts
        "lxappearance-gtk3"
        "nwg-look"
        "qt5ct"
        "qt6ct"
        "kvantum-qt5"
        "kvantum"
        "ttf-ubuntu-nerd"
        "ttf-mononoki-nerd"
        "papirus-icon-theme"

        # Benchmarking
        "s-tui"
        "stress"

        # Other
        "git"
        "lm_sensors"
        "pass"
        "pass-otp"
        "gparted"
        "wget"
        "lxsession"
        "monero-gui"
        "nano"
        "code"
        "htop"
        "xdg-user-dirs"
)

desktop_packages=(
	# Fancontrol/RGB
        "liquidctl"
	"openrgb"
	"i2c-tools"

	# Virtualisation
        "qemu"
        "libvirt"
        "edk2-ovmf"
        "virt-manager"
        "dnsmasq"
        "nftables"
)

laptop_packages=(
	# Power management/Screen brightness/Volume control
	"tlp"
	"brightnessctl"
	"pulsemixer"
)

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

services() {
	systemctl enable fstrim
	systemctl enable sshd
	systemctl enable greetd
}

desktop_services() {
	systemctl enable libvirtd
}

laptop_services() {
	systemctl enable tlp
}

swapfile() {
	chmod 0600 /swapfile
	mkswap -U clear /swapfile
	swapon /swapfile
	echo "/swapfile none swap defaults 0 0" >> /etc/fstab
}

grub() {
	wget https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/arch-linux.tar -P /home/${user}/Downloads
	mkdir /home/${user}/Downloads/arch-grub-theme
	tar -xf /home/${user}/Downloads/arch-linux.tar -C /home/${user}/Downloads/arch-grub-theme
	mkdir -p /boot/grub/themes
	cp -r /home/${user}/Downloads/arch-grub-theme /boot/grub/themes/arch
	sed -i 's|^#GRUB_THEME.*|GRUB_THEME=/boot/grub/themes/arch/theme.txt|' /etc/default/grub
	rm -r /home/${user}/Downloads/arch-grub-theme
	rm -r /home/${user}/Downloads/arch-linux.tar
	swap_uuid=$(cat /etc/fstab | tail -n5 | head -n1 | awk '{print $1}')
	swap_offset=$(filefrag -v /swapfile | head -n 4 | tail -n 1 | awk '{print $4}' | sed 's/\..//')
}

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
	sudo -u ${user} git clone https://github.com/juipeltje/configs /home/${user}/configs
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
	cp -f /home/${user}/configs/common/etc/greetd/config.toml /etc/greetd/
}

configs_desktop() {
	sudo -u ${user} cp -f /home/${user}/configs/workstation/home/.bashrc /home/${user}/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/hypr/* /home/${user}/.config/hypr/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/i3/* /home/${user}/.config/i3/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/polybar /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/qtile /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/sway/* /home/${user}/.config/sway/
	sudo -u ${user} cp -rf /home/${user}/configs/workstation/home/dotconfig/waybar /home/${user}/.config/
	cp -f /home/${user}/configs/workstation/etc/greetd/regreet.toml /etc/greetd/
	cp -f /home/${user}/configs/workstation/etc/greetd/hyprland-config /etc/greetd/
}

configs_laptop() {
	sudo -u ${user} cp -f /home/${user}/configs/laptop/home/.bashrc /home/${user}/
	sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/hypr/* /home/${user}/.config/hypr/
        sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/i3/* /home/${user}/.config/i3/
        sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/polybar /home/${user}/.config/
        sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/qtile /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/sway/* /home/${user}/.config/sway/
        sudo -u ${user} cp -rf /home/${user}/configs/laptop/home/dotconfig/waybar /home/${user}/.config/
	cp -f /home/${user}/configs/laptop/etc/greetd/regreet.toml /etc/greetd/
	cp -f /home/${user}/configs/laptop/etc/greetd/hyprland-config /etc/greetd/
	cp -rf /home/${user}/configs/laptop/etc/X11/xorg.conf.d /etc/X11/
	cp -f /home/${user}/configs/laptop/etc/tlp.conf /etc/
}

desktop_entries() {
	echo "[Desktop Entry]
	Name=Qtile (startx)
	Comment=Qtile session started with startx for regreet display manager
	Exec=startx ~/.xinitrc-qtile
	Type=Application
	Keywords=wm;tiling" >> /usr/share/xsessions/qtile-startx.desktop
	echo "[Desktop Entry]
	Name=i3 (startx)
	Comment=i3 session started with startx for regreet display manager
	Exec=startx ~/.xinitrc-i3
	Type=Application
	Keywords=wm;tiling" >> /usr/share/xsessions/i3-startx.desktop
}

echo -e "${bright_cyan}This script will install both global system configurations as well as dotfiles in the user's home folder.
Confirm you understand this keeping in mind that something could go wrong and brick your system.${color_reset}"

select opt_1 in "${options_1[@]}"
do
	case ${opt_1} in
		"confirm") 
                	echo -e "${bright_cyan}Continuing with post-install script...${color_reset}" 
		   	break
		   	;;
		"exit script") 
			echo -e "${bright_cyan}Exiting post-install script...${color_reset}"
	           	exit 68 
		   	;;
		*)
			echo -e "${red}Invalid option, please try again.${color_reset}"
			;;
	esac
done

echo -e "${bright_cyan}Please enter the username of your machine. this will be used as a variable in the install script.${color_reset}"

read user;

echo -e "${bright_cyan}Continuing post-install script as '${user}'...${color_reset}"

echo -e "${bright_cyan}One last question: are you using a desktop, laptop, or virtual machine?${color_reset}"

select opt_2 in "${options_2[@]}"
do
	case ${opt_2} in
		"desktop")
			echo -e "${bright_cyan}Continuing post-install script with settings for desktop${color_reset}"

			# Install packages
			echo -e "${bright_cyan}Installing packages...${color_reset}"
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"
        		pacman -S --noconfirm --needed "${desktop_packages[@]}"

			# Create user directories
			echo -e "${bright_cyan}Creating user directories...${color_reset}"
			sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${bright_cyan}Installing config files...${color_reset}"
			rm_default_configs
			configs
			configs_desktop
			cp -rf /home/${user}/configs/workstation/etc/X11/xorg.conf.d /etc/X11/

			# Add user to groups
			echo -e "${bright_cyan}Adding user to groups...${color_reset}"
        		usermod -aG kvm,libvirt ${user}

			# Kernel modules
			echo -e "${bright_cyan}Adding kernel modules to load on boot...${color_reset}"
        		echo "i2c-dev" >> /etc/modules-load.d/i2c.conf
        		echo "i2c-piix4" >> /etc/modules-load.d/i2c-piix4.conf
        		echo "options vfio-pci ids=10de:1287,10de:0e0f" >> /etc/modprobe.d/vfio.conf
        		mkinitcpio -P

			# Swap
			echo -e "${bright_cyan}Setting up swapfile...${color_reset}"
			dd if=/dev/zero of=/swapfile bs=1M count=48k status=progress
			swapfile

			# Grub
			echo -e "${bright_cyan}Configuring grub...${color_reset}"
        		grub
        		sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=${swap_uuid} resume_offset=${swap_offset} amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=3\"/" /etc/default/grub
        		sed -i 's/^GRUB_GFXMODE.*/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
        		grub-mkconfig -o /boot/grub/grub.cfg

			# Services
			echo -e "${bright_cyan}Enabling systemd services...${color_reset}"
        		services
			desktop_services

			# Desktop entries
			echo -e "${bright_cyan}Setting up desktop entries...${color_reset}"
			desktop_entries

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		"laptop")
			echo -e "${bright_cyan}Continuing post-install script with settings for laptop...${color_reset}"

			# Install packages
			echo -e "${bright_cyan}Installing packages...${color_reset}"
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"
        		pacman -S --noconfirm --needed "${laptop_packages[@]}"

			# Create user directories
			echo -e "${bright_cyan}Creating user directories...${color_reset}"
                        sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${bright_cyan}Installing config files...${color_reset}"
                        rm_default_configs
                        configs
			configs_laptop

			# Add user to groups
			# echo -e "${bright_cyan}Adding user to groups...${color_reset}"
        		# usermod -aG kvm,libvirt ${user}

			# Swap
			echo -e "${bright_cyan}Setting up swapfile...${color_reset}"
			dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress
			swapfile

			# Grub
			echo -e "${bright_cyan}Configuring grub...${color_reset}"
        		grub
        		sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=${swap_uuid} resume_offset=${swap_offset} amdgpu.ppfeaturemask=0xffffffff loglevel=3\"/" /etc/default/grub
        		sed -i 's/^GRUB_GFXMODE.*/GRUB_GFXMODE=1920x1080x32,auto/' /etc/default/grub
        		grub-mkconfig -o /boot/grub/grub.cfg

			# Battery
			echo -e "${bright_cyan}Setting up battery script and crontab for auto-hibernate when battery is low...${color_reset}"

			# Services
			echo -e "${bright_cyan}Enabling systemd services...${color_reset}"
        		services
        		laptop_services

			# Desktop entries
			echo -e "${bright_cyan}Setting up desktop entries...${color_reset}"
                        desktop_entries

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		"virtual machine")
			echo -e "${bright_cyan}Continuing post-install script with settings for virtual machine...${color_reset}"

			# Install packages
			echo -e "${bright_cyan}Installing packages...${color_reset}"
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"

			# Create user directories
			echo -e "${bright_cyan}Creating user directories...${color_reset}"
                        sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${bright_cyan}Installing config files...${color_reset}"
                        rm_default_configs
                        configs
                        configs_desktop

			# Add user to groups
			# echo -e "${bright_cyan}Adding user to groups...${color_reset}"
        		# usermod -aG kvm,libvirt ${user}

			# Services
			echo -e "${bright_cyan}Enabling systemd services...${color_reset}"
        		services

			# Desktop entries
			echo -e "${bright_cyan}Setting up desktop entries...${color_reset}"
                        desktop_entries

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		*)
			echo -e "${red}Invalid option, please try again.${color_reset}"
			;;
	esac
done
