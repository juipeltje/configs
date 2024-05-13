#!/bin/bash

# post install script for arch linux

set -e

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
	# Power management/Screen brightness
	"tlp"
	"brightnessctl"
)

aur_packages=(
	"swayfx" 
	"prismlauncher" 
	"swaylock-effects" 
)

options_1=(
	"1 - confirm"
      	"2 - exit script"
)

options_2=(
	"1 - desktop"
	"2 - laptop"
	"3 - virtual machine"
)

# Functions

services() {
	systemctl enable fstrim
	systemctl enable sshd
	systemctl enable libvirtd
	systemctl enable greetd
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
	wget https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/arch-linux.tar -P /home/$user/Downloads
	mkdir /home/$user/Downloads/arch-grub-theme
	tar -xf /home/$user/Downloads/arch-linux.tar -C /home/$user/Downloads/arch-grub-theme
	mkdir -p /boot/grub/themes
	cp -r /home/$user/Downloads/arch-grub-theme /boot/grub/themes/arch
	sed -i 's|#GRUB_THEME="/path/to/gfxtheme"|GRUB_THEME=/boot/grub/themes/arch/theme.txt|' /etc/default/grub
	rm -r /home/$user/Downloads/arch-grub-theme
	rm -r /home/$user/Downloads/arch-linux.tar
	swap_uuid=$(cat /etc/fstab | tail -n5 | head -n1 | awk '{print $1}')
	swap_offset=$(filefrag -v /swapfile | head -n 4 | tail -n 1 | awk '{print $4}' | sed 's/\..//')
}

greeter() {
	rm -f /etc/greetd/config.toml
	wget -P /etc/greetd https://raw.githubusercontent.com/juipeltje/configs/main/workstation/config-files/etc/greetd/config.toml
}

rm_default_configs() {
	sudo -u $user rm -rf /home/$user/.bashrc
	sudo -u $user rm -rf /home/$user/.bash_profile
	sudo -u $user rm -rf /home/$user/.Xresources
	sudo -u $user rm -rf /home/$user/.config/alacritty
	sudo -u $user rm -rf /home/$user/.config/dunst
	sudo -u $user rm -rf /home/$user/.config/git
	sudo -u $user rm -rf /home/$user/.config/hypr
	sudo -u $user rm -rf /home/$user/.config/i3
	sudo -u $user rm -rf /home/$user/.config/mako
	sudo -u $user rm -rf /home/$user/.config/mpv
	sudo -u $user rm -rf /home/$user/.config/polybar
	sudo -u $user rm -rf /home/$user/.config/qtile
	sudo -u $user rm -rf /home/$user/.config/rofi
	sudo -u $user rm -rf /home/$user/.config/sway
	sudo -u $user rm -rf /home/$user/.config/waybar
	sudo -u $user rm -rf /home/$user/.config/wofi
	sudo -u $user rm -rf /home/$user/.config/yazi
}

configs() {


echo "This script will install both global system configurations as well as dotfiles in the user's home folder. \
Confirm you understand this keeping in mind that something could go wrong and brick your system."

select opt_1 in "${options_1[@]}"
do
	case $opt_1 in
		"1 - confirm") 
                	echo "continuing with post-install script..." 
		   	break
		   	;;
		"2 - exit script") 
			echo "exiting post-install script..."
	           	exit 68 
		   	;;
	esac
done

echo "please enter the username of your machine. this will be used as a variable in the install script"

read user;

echo "continuing post-install script as '$user'..."

echo "one last question: are you using a desktop, laptop, or virtual machine?"

select opt_2 in "${options_2[@]}"
do
	case $opt_2 in
		"1 - desktop")
			echo "continuing post-install script with settings for desktop"
			echo "installing packages..."
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"
        		pacman -S --noconfirm --needed "${desktop_packages[@]}"
        		echo "adding user to groups..."
        		usermod -aG kvm,libvirt $user
        		echo "adding kernel modules to load on boot..."
        		echo "i2c-dev" >> /etc/modules-load.d/i2c.conf
        		echo "i2c-piix4" >> /etc/modules-load.d/i2c-piix4.conf
        		echo "options vfio-pci ids=10de:1287,10de:0e0f" >> /etc/modprobe.d/vfio.conf
        		mkinitcpio -P
        		echo "setting up swapfile..."
			dd if=/dev/zero of=/swapfile bs=1M count=48k status=progress
			swapfile
        		echo "configuring grub..."
        		grub
        		sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"loglevel=3 quiet\"/GRUB_CMDLINE_LINUX_DEFAULT=\"amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=3\"/" /etc/default/grub
        		sed -i 's/GRUB_GFXMODE=auto/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
        		grub-mkconfig -o /boot/grub/grub.cfg
        		echo "setting up greeter..."
			greeter
        		wget -P /etc/greetd https://raw.githubusercontent.com/juipeltje/configs/main/workstation/config-files/etc/greetd/hyprland-config
        		echo "enabling systemd services..."
        		services
        		echo "Finished!! You can now reboot your machine."
			exit 69
			;;
		"2 - laptop")
			echo "continuing post-install script with settings for laptop..."
			echo "installing packages..."
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"
        		pacman -S --noconfirm --needed "${laptop_packages[@]}"
        		echo "installing config files..."
        		echo "adding user to groups..."
        		usermod -aG kvm,libvirt $user
        		echo "setting up swapfile..."
			dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress
			swapfile
        		echo "configuring grub..."
        		grub
        		sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"loglevel=3 quiet\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$swap_uuid resume_offset=$swap_offset amdgpu.ppfeaturemask=0xffffffff loglevel=3\"/" /etc/default/grub
        		sed -i 's/GRUB_GFXMODE=auto/GRUB_GFXMODE=1920x1080x32,auto/' /etc/default/grub
        		grub-mkconfig -o /boot/grub/grub.cfg
        		echo "setting up battery script and crontab for auto-hibernate when battery is low..."
        		echo "enabling systemd services..."
        		services
        		laptop_services
        		echo "Finished!! You can now reboot your machine."
			exit 69
			;;
		"3 - virtual machine")
			echo "continuing post-install script with settings for virtual machine..."
			echo "installing packages..."
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"
        		echo "installing config files..."
        		echo "adding user to groups..."
        		usermod -aG kvm,libvirt $user
        		echo "enabling systemd services..."
        		services
        		echo "Finished!! You can now reboot your machine."
			exit 69
			;;
	esac
done
