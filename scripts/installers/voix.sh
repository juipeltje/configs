#!/usr/bin/env bash

# post install script for a minimal void linux setup with nix layered on top

set -e

# Variables
color_reset="\033[0m"
green="\033[0;32m"
red="\033[0;31m"
bright_green="\033[0;92m"
PS3=$'\e[0;32m'"->"$'\e[m'

# Arrays

repos=(
	# extra repos
        "void-repo-multilib"
        "void-repo-multilib-nonfree"
        "void-repo-nonfree"
)

packages=(
        # Wayland/Compositors
	"gtklock"

        # Gaming
        "vulkan-loader"
	"vulkan-loader-32bit"
	"mesa-vulkan-radeon"
        "mesa-vulkan-radeon-32bit"
	"mesa"
        "mesa-32bit"
	"mesa-dri"
        "mesa-dri-32bit"
	"mesa-vaapi"
	"mesa-vaapi-32bit"
        "mesa-vdpau"
	"mesa-vdpau-32bit"
	"corectrl"
	"qt6-wayland"
	"steam"
        "gamemode"

        # Networking
	"NetworkManager"
        "openssh"
	"wireguard-dkms"
        "wireguard-tools"

        # Bluetooth
        "bluez"

        # File managers/utilities
	"pcmanfm"
	"xz"
        "gvfs"
        "fuse3"

        # Multimedia
	"pipewire"
        "wireplumber"

	# Virtualisation
        "qemu"
        "libvirt"
        "virt-manager"
        "dnsmasq"
        "nftables"
        "swtpm"

        # Other
        "git"
        "gparted"
        "wget"
        "polkit-gnome"
        "nano"
        "htop"
        "xdg-user-dirs"
	"elogind"
        "socklog-void"
        "cronie"
	"curl"
	"xtools"
	"nix"
	"gnome-keyring"
)

desktop_packages=(
	# RGB
	"openrgb"
	"i2c-tools"
)

laptop_packages=(
	# Power management/Screen brightness/Volume control
	"tlp"
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
	ln -s /etc/sv/NetworkManager /var/service/
        ln -s /etc/sv/dbus /var/service/
        ln -s /etc/sv/bluetoothd /var/service/
        ln -s /etc/sv/ntpd /var/service/
        ln -s /etc/sv/socklog-unix /var/service/
        ln -s /etc/sv/nanoklogd /var/service/
        ln -s /etc/sv/cronie /var/service/
	ln -s /etc/sv/nix-daemon /var/service/
	rm -rf /var/service/dhcpcd
	rm -rf /var/service/wpa_supplicant
	cp -rf /etc/sv/agetty-tty1 /etc/sv/agetty-autologin-tty1
	sed -i "s/GETTY_ARGS.*/GETTY_ARGS=\"--autologin ${user} --noclear\"/" /etc/sv/agetty-autologin-tty1/conf
}

desktop_services() {
	ln -s /etc/sv/libvirtd /var/service/
	ln -s /etc/sv/virtlockd /var/service/
	ln -s /etc/sv/virtlogd /var/service/
	ln -s /etc/sv/openrgb /var/service/
}

laptop_services() {
	ln -s /etc/sv/tlp /var/service/
	rm -rf /var/service/acpid
}

swapfile() {
	chmod 0600 /swapfile
	mkswap -U clear /swapfile
	swapon /swapfile
	echo "/swapfile none swap defaults 0 0" >> /etc/fstab
}

grub() {
	wget https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/void-linux.tar -P /home/${user}/Downloads
	mkdir /home/${user}/Downloads/void-grub-theme
	tar -xf /home/${user}/Downloads/void-linux.tar -C /home/${user}/Downloads/void-grub-theme
	mkdir -p /boot/grub/themes
	cp -r /home/${user}/Downloads/void-grub-theme /boot/grub/themes/void
	echo 'GRUB_THEME="/boot/grub/themes/void/theme.txt"' >> /etc/default/grub
	echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
	rm -r /home/${user}/Downloads/void-grub-theme
	rm -r /home/${user}/Downloads/void-linux.tar
	swap_uuid=$(cat /etc/fstab | head -n1 | awk '{print $1}')
        swap_offset=$(filefrag -v /swapfile | head -n 4 | tail -n 1 | awk '{print $4}' | sed 's/\..//')
	sed -i 's/^GRUB_TIMEOUT.*/GRUB_TIMEOUT=0/' /etc/default/grub
	sed -i 's/^#GRUB_HIDDEN_TIMEOUT=.*/GRUB_HIDDEN_TIMEOUT=1/' /etc/default/grub
}

rm_default_configs() {
	# Xorg-related configs, disabled for now.
	#sudo -u ${user} rm -rf /home/${user}/.Xresources
	#sudo -u ${user} rm -rf /home/${user}/.config/dunst
	#sudo -u ${user} rm -rf /home/${user}/.config/i3
	#sudo -u ${user} rm -rf /home/${user}/.config/picom
	#sudo -u ${user} rm -rf /home/${user}/.config/polybar
	#sudo -u ${user} rm -rf /home/${user}/.config/rofi

	# remove default configs if present.
	sudo -u ${user} rm -rf /home/${user}/.bashrc
	sudo -u ${user} rm -rf /home/${user}/.bash_profile
	sudo -u ${user} rm -rf /home/${user}/.config/alacritty
	sudo -u ${user} rm -rf /home/${user}/.config/fastfetch
	sudo -u ${user} rm -rf /home/${user}/.config/foot
	sudo -u ${user} rm -rf /home/${user}/.config/fuzzel
	sudo -u ${user} rm -rf /home/${user}/.config/git
	sudo -u ${user} rm -rf /home/${user}/.config/gtklock
	sudo -u ${user} rm -rf /home/${user}/.config/hypr
	sudo -u ${user} rm -rf /home/${user}/.config/kanshi
	sudo -u ${user} rm -rf /home/${user}/.config/kitty
	sudo -u ${user} rm -rf /home/${user}/.config/mako
	sudo -u ${user} rm -rf /home/${user}/.config/maomao
	sudo -u ${user} rm -rf /home/${user}/.config/mpd
	sudo -u ${user} rm -rf /home/${user}/.config/mpv
	sudo -u ${user} rm -rf /home/${user}/.config/mwc
	sudo -u ${user} rm -rf /home/${user}/.config/nano
	sudo -u ${user} rm -rf /home/${user}/.config/niri
	sudo -u ${user} rm -rf /home/${user}/.config/pipewire
	sudo -u ${user} rm -rf /home/${user}/.config/qtile
	sudo -u ${user} rm -rf /home/${user}/.config/river
	sudo -u ${user} rm -rf /home/${user}/.config/sway
	sudo -u ${user} rm -rf /home/${user}/.config/swayidle
	sudo -u ${user} rm -rf /home/${user}/.config/tofi
	sudo -u ${user} rm -rf /home/${user}/.config/VSCodium
	sudo -u ${user} rm -rf /home/${user}/.config/waybar
	sudo -u ${user} rm -rf /home/${user}/.config/yazi
}

configs() {
	# Xorg-related configs, disabled for now.
	#sudo -u ${user} cp -f /home/${user}/repos/configs/dotfiles/common/.Xresources /home/${user}/
	#sudo -u ${user} cp -f /home/${user}/repos/configs/dotfiles/common/.xinitrc-i3 /home/${user}/
        #sudo -u ${user} cp -f /home/${user}/repos/configs/dotfiles/common/.xinitrc-qtile /home/${user}/
	#sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/dunst /home/${user}/.config/
	#sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/i3 /home/${user}/.config/
	#sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/picom /home/${user}/.config/
	#sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/rofi /home/${user}/.config/

	# copy common configs to .config
	sudo -u ${user} git clone https://github.com/juipeltje/configs /home/${user}/repos/configs
	sudo -u ${user} cp -f /home/${user}/repos/configs/dotfiles/common/.bashrc /home/${user}/
	sudo -u ${user} cp -f /home/${user}/repos/configs/dotfiles/common/.bash_profile /home/${user}/
	sudo -u ${user} mkdir -p /home/${user}/.config
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/alacritty /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/fastfetch /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/foot /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/fuzzel /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/git /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/gtklock /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/hypr /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/kitty /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/mako /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/maomao /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/mpd /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/mpv /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/nano /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/pipewire /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/qtile /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/river /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/sway /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/tofi /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/VSCodium /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/waybar /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/common/dotconfig/yazi /home/${user}/.config/
}

configs_desktop() {
	# Xorg-related configs, disabled for now.
	#sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/i3/* /home/${user}/.config/i3/
	#sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/polybar /home/${user}/.config/
	#cp -rf /home/${user}/repos/configs/workstation/etc/X11/xorg.conf.d /etc/X11/

	# copy desktop configs to .config
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/hypr/* /home/${user}/.config/hypr/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/kanshi /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/maomao/* /home/${user}/.config/maomao/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/mwc /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/niri /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/qtile/* /home/${user}/.config/qtile/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/river/* /home/${user}/.config/river/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/sway/* /home/${user}/.config/sway/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/swayidle /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/tofi/* /home/${user}/.config/tofi/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/workstation/dotconfig/waybar/* /home/${user}/.config/waybar/
}

configs_laptop() {
	# Xorg-related configs, disabled for now.
	#sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/i3/* /home/${user}/.config/i3/
	#sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/polybar /home/${user}/.config/
	#cp -rf /home/${user}/repos/configs/laptop/etc/X11/xorg.conf.d /etc/X11/

	# copy laptop configs to .config
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/hypr/* /home/${user}/.config/hypr/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/niri /home/${user}/.config/
        sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/qtile/* /home/${user}/.config/qtile/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/river/* /home/${user}/.config/river/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/sway/* /home/${user}/.config/sway/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/swayidle /home/${user}/.config/
	sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/tofi/* /home/${user}/.config/tofi/
        sudo -u ${user} cp -rf /home/${user}/repos/configs/dotfiles/laptop/dotconfig/waybar/* /home/${user}/.config/waybar/
	cp -f /home/${user}/repos/configs/void-stuff/laptop/etc/tlp.conf /etc/
}

pipewire() {
	mkdir -p /etc/pipewire/pipewire.conf.d
        ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
        ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
}

echo -e "${green}This script will install both global system configurations as well as dotfiles in the user's home folder.
Confirm you understand this keeping in mind that something could go wrong and brick your system.${color_reset}"

select opt_1 in "${options_1[@]}"
do
	case ${opt_1} in
		"confirm")
                	echo -e "${green}Continuing with post-install script...${color_reset}"
		   	break
		   	;;
		"exit script")
			echo -e "${green}Exiting post-install script...${color_reset}"
	           	exit 68
		   	;;
		*)
			echo -e "${red}Invalid option, please try again.${color_reset}"
			;;
	esac
done

echo -e "${green}Please enter the username of your machine. this will be used as a variable in the install script.${color_reset}"

read user;

echo -e "${green}Continuing post-install script as '${user}'...${color_reset}"

echo -e "${green}One last question: are you using a desktop, laptop, or virtual machine?${color_reset}"

select opt_2 in "${options_2[@]}"
do
	case ${opt_2} in
		"desktop")
			echo -e "${green}Continuing post-install script with settings for desktop${color_reset}"

			# Install packages
			echo -e "${green}Installing packages...${color_reset}"
			xbps-install -uy xbps
        		xbps-install -Suy
        		xbps-install -Sy "${repos[@]}"
        		xbps-install -Sy "${packages[@]}"
        		xbps-install -Sy "${desktop_packages[@]}"

			# Creating user directories
			echo -e "${green}Creating user directories...${color_reset}"
			sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${green}Installing config files...${color_reset}"
			rm_default_configs
			configs
			configs_desktop

			# Pipewire
			echo -e "${green}configuring pipewire...${color_reset}"
        		pipewire

			# Add user to groups
			echo -e "${green}Adding user to groups...${color_reset}"
			usermod -aG i2c,kvm,libvirt,bluetooth,socklog,gamemode ${user}

			# Kernel modules
			echo -e "${green}Adding kernel modules to load on boot...${color_reset}"
        		echo "i2c-dev" > /etc/modules-load.d/i2c.conf
        		echo "i2c-piix4" > /etc/modules-load.d/i2c-piix4.conf
        		echo "options vfio-pci ids=10de:1287,10de:0e0f" > /etc/modprobe.d/vfio.conf
			echo "softdep drm pre: vfio-pci" >> /etc/modprobe.d/vfio.conf
			echo -e "force_drivers+=\" vfio_pci vfio vfio_iommu_type1 \"" > /etc/dracut.conf.d/10-vfio.conf
        		dracut --force

			# Swap
			echo -e "${green}Setting up swapfile...${color_reset}"
			dd if=/dev/zero of=/swapfile bs=1M count=48k status=progress
			swapfile

			# Grub
			echo -e "${green}Configuring grub...${color_reset}"
        		grub
        		sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=${swap_uuid} resume_offset=${swap_offset} amdgpu.ppfeaturemask=0xffffffff iommu=pt vfio-pci.ids=10de:1287,10de:0e0f loglevel=4\"/" /etc/default/grub
        		sed -i 's/^#GRUB_GFXMODE.*/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
        		update-grub

			# SSD trim
			echo -e "${green}setting up weekly cronjob for SSD trimming...${color_reset}"
        		cp /home/${user}/repos/configs/scripts/cron/fstrim.sh /etc/cron.weekly/

			# Services
			echo -e "${green}Enabling runit services...${color_reset}"
        		services
			desktop_services

			# crontab
			echo -e "${green}Installing crontab...${color_reset}"
			crontab /home/${user}/repos/configs/void-stuff/workstation/root-crontab.txt

			# Done
			echo -e "${bright_green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		"laptop")
			echo -e "${green}Continuing post-install script with settings for laptop...${color_reset}"

			# Install packages
			echo -e "${green}Installing packages...${color_reset}"
			xbps-install -uy xbps
        		xbps-install -Suy
        		xbps-install -Sy "${repos[@]}"
        		xbps-install -Sy "${packages[@]}"
        		xbps-install -Sy "${laptop_packages[@]}"

			# Creating user directories
                        echo -e "${green}Creating user directories...${color_reset}"
                        sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${green}Installing config files...${color_reset}"
                        rm_default_configs
                        configs
			configs_laptop

			# Pipewire
                        echo -e "${green}configuring pipewire...${color_reset}"
                        pipewire

			# Add user to groups
			echo -e "${green}Adding user to groups...${color_reset}"
        		usermod -aG kvm,libvirt,bluetooth,socklog,gamemode ${user}

			# Swap
			echo -e "${green}Setting up swapfile...${color_reset}"
			dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress
			swapfile

			# Grub
			echo -e "${green}Configuring grub...${color_reset}"
        		grub
        		sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=${swap_uuid} resume_offset=${swap_offset} amdgpu.ppfeaturemask=0xffffffff loglevel=4\"/" /etc/default/grub
        		update-grub

			# SSD trim
                        echo -e "${green}setting up weekly cronjob for SSD trimming...${color_reset}"
                        cp /home/${user}/repos/configs/scripts/cron/fstrim.sh /etc/cron.weekly/

			# Services
			echo -e "${green}Enabling runit services...${color_reset}"
        		services
        		laptop_services

			# crontab
                        echo -e "${green}Installing crontab...${color_reset}"
                        crontab /home/${user}/repos/configs/void-stuff/laptop/root-crontab.txt

			# Done
			echo -e "${bright_green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		"virtual machine")
			echo -e "${green}Continuing post-install script with settings for virtual machine...${color_reset}"

			# Install packages
			echo -e "${green}Installing packages...${color_reset}"
			xbps-install -uy xbps
        		xbps-install -Suy
        		xbps-install -Sy "${repos[@]}"
        		xbps-install -Sy "${packages[@]}"

			# Creating user directories
                        echo -e "${green}Creating user directories...${color_reset}"
                        sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${green}Installing config files...${color_reset}"
                        rm_default_configs
                        configs
                        configs_desktop

			# Pipewire
                        echo -e "${green}configuring pipewire...${color_reset}"
                        pipewire

			# Add user to groups
			echo -e "${green}Adding user to groups...${color_reset}"
			usermod -aG kvm,libvirt,bluetooth,socklog,gamemode ${user}

			# Services
			echo -e "${green}Enabling runit services...${color_reset}"
        		services

			# Done
			echo -e "${bright_green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		*)
			echo -e "${red}Invalid option, please try again.${color_reset}"
			;;
	esac
done
