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
	sed -i 's|^#GRUB_THEME.*|GRUB_THEME=/boot/grub/themes/arch/theme.txt|' /etc/default/grub
	rm -r /home/$user/Downloads/arch-grub-theme
	rm -r /home/$user/Downloads/arch-linux.tar
	swap_uuid=$(cat /etc/fstab | tail -n5 | head -n1 | awk '{print $1}')
	swap_offset=$(filefrag -v /swapfile | head -n 4 | tail -n 1 | awk '{print $4}' | sed 's/\..//')
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
	sudo -u $user git clone https://github.com/juipeltje/configs /home/$user/configs
	sudo -u $user cp -rf /home/$user/configs/common/home/.bash_profile /home/$user/
	sudo -u $user cp -rf /home/$user/configs/common/home/.xinitrc-i3 /home/$user/
	sudo -u $user cp -rf /home/$user/configs/common/home/.xinitrc-qtile /home/$user/
	sudo -u $user mkdir -p /home/$user/.config
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/alacritty /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/dunst /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/git /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/hypr /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/i3 /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/mako /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/mpv /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/pipewire /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/rofi /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/sway /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/tofi /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/wofi /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/common/home/dotconfig/yazi /home/$user/.config/
	cp -f /home/$user/configs/common/etc/greetd/config.toml /etc/greetd/
}

configs_desktop() {
	sudo -u $user cp -rf /home/$user/configs/workstation/home/dotconfig/hypr/* /home/$user/.config/hypr/
	sudo -u $user cp -rf /home/$user/configs/workstation/home/dotconfig/i3/* /home/$user/.config/i3/
	sudo -u $user cp -rf /home/$user/configs/workstation/home/dotconfig/polybar /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/workstation/home/dotconfig/qtile /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/workstation/home/dotconfig/sway/* /home/$user/.config/sway/
	sudo -u $user cp -rf /home/$user/configs/workstation/home/dotconfig/waybar /home/$user/.config/
	cp -f /home/$user/configs/workstation/etc/greetd/regreet.toml /etc/greetd/
	cp -f /home/$user/configs/workstation/etc/greetd/hyprland-config /etc/greetd/
}

configs_laptop() {
	sudo -u $user cp -rf /home/$user/configs/laptop/home/dotconfig/hypr/* /home/$user/.config/hypr/
        sudo -u $user cp -rf /home/$user/configs/laptop/home/dotconfig/i3/* /home/$user/.config/i3/
        sudo -u $user cp -rf /home/$user/configs/laptop/home/dotconfig/polybar /home/$user/.config/
        sudo -u $user cp -rf /home/$user/configs/laptop/home/dotconfig/qtile /home/$user/.config/
	sudo -u $user cp -rf /home/$user/configs/laptop/home/dotconfig/sway/* /home/$user/.config/sway/
        sudo -u $user cp -rf /home/$user/configs/laptop/home/dotconfig/waybar /home/$user/.config/
	cp -f /home/$user/configs/laptop/etc/greetd/regreet.toml /etc/greetd/
	cp -f /home/$user/configs/laptop/etc/greetd/hyprland-config /etc/greetd/
	cp -rf /home/$user/configs/laptop/etc/X11/xorg.conf.d /etc/X11/
	cp -f /home/$user/configs/laptop/etc/tlp.conf /etc/
}

aur() {
	pacman -S --needed base-devel
	sudo -u $user git clone https://aur.archlinux.org/paru.git /home/$user/paru
	cd /home/$user/paru
	sudo -u $user makepkg -si
	cd
	paru -S --noconfirm "${aur_packages[@]}"
}

startx() {
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

echo "This script will install both global system configurations as well as dotfiles in the user's home folder.
Confirm you understand this keeping in mind that something could go wrong and brick your system."

select opt_1 in "${options_1[@]}"
do
	case $opt_1 in
		"1 - confirm") 
                	echo "Continuing with post-install script..." 
		   	break
		   	;;
		"2 - exit script") 
			echo "Exiting post-install script..."
	           	exit 68 
		   	;;
	esac
done

echo "Please enter the username of your machine. this will be used as a variable in the install script."

read user;

echo "Continuing post-install script as '$user'..."

echo "One last question: are you using a desktop, laptop, or virtual machine?"

select opt_2 in "${options_2[@]}"
do
	case $opt_2 in
		"1 - desktop")
			echo "Continuing post-install script with settings for desktop"
			echo "Installing packages..."
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"
        		pacman -S --noconfirm --needed "${desktop_packages[@]}"
			echo "Creating user directories..."
			sudo -u $user xdg-user-dirs-update
			echo "Installing config files..."
			rm_default_configs
			configs
			configs_desktop
			cp -rf /home/$user/configs/workstation/etc/X11/xorg.conf.d /etc/X11/
        		echo "Adding user to groups..."
        		usermod -aG kvm,libvirt $user
        		echo "Adding kernel modules to load on boot..."
        		echo "i2c-dev" >> /etc/modules-load.d/i2c.conf
        		echo "i2c-piix4" >> /etc/modules-load.d/i2c-piix4.conf
        		echo "options vfio-pci ids=10de:1287,10de:0e0f" >> /etc/modprobe.d/vfio.conf
        		mkinitcpio -P
        		echo "Setting up swapfile..."
			dd if=/dev/zero of=/swapfile bs=1M count=48k status=progress
			swapfile
        		echo "Configuring grub..."
        		grub
        		sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$swap_uuid resume_offset=$swap_offset amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=3\"/" /etc/default/grub
        		sed -i 's/^GRUB_GFXMODE.*/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
        		grub-mkconfig -o /boot/grub/grub.cfg
        		echo "Enabling systemd services..."
        		services
			echo "Installing paru and aur packages..."
			aur
			echo "Setting up desktop entries for startx..."
			startx
        		echo -e "'\033[0;32m'Finished!! You can now reboot your machine.'\033[0m'"
			exit 69
			;;
		"2 - laptop")
			echo "Continuing post-install script with settings for laptop..."
			echo "Installing packages..."
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"
        		pacman -S --noconfirm --needed "${laptop_packages[@]}"
			echo "Creating user directories..."
                        sudo -u $user xdg-user-dirs-update
                        echo "Installing config files..."
                        rm_default_configs
                        configs
			configs_laptop
        		echo "Adding user to groups..."
        		usermod -aG kvm,libvirt $user
        		echo "Setting up swapfile..."
			dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress
			swapfile
        		echo "Configuring grub..."
        		grub
        		sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$swap_uuid resume_offset=$swap_offset amdgpu.ppfeaturemask=0xffffffff loglevel=3\"/" /etc/default/grub
        		sed -i 's/^GRUB_GFXMODE.*/GRUB_GFXMODE=1920x1080x32,auto/' /etc/default/grub
        		grub-mkconfig -o /boot/grub/grub.cfg
        		echo "Setting up battery script and crontab for auto-hibernate when battery is low..."
        		echo "Enabling systemd services..."
        		services
        		laptop_services
			echo "Installing paru and aur packages..."
                        aur
			echo "Setting up desktop entries for startx..."
                        startx
			echo -e "'\033[0;32m'Finished!! You can now reboot your machine.'\033[0m'"
			exit 69
			;;
		"3 - virtual machine")
			echo "Continuing post-install script with settings for virtual machine..."
			echo "Installing packages..."
        		pacman -Syu --noconfirm
        		pacman -S --noconfirm --needed "${packages[@]}"
			echo "Creating user directories..."
                        sudo -u $user xdg-user-dirs-update
                        echo "Installing config files..."
                        rm_default_configs
                        configs
                        configs_desktop
        		echo "Adding user to groups..."
        		usermod -aG kvm,libvirt $user
        		echo "Enabling systemd services..."
        		services
			echo "Installing paru and aur packages..."
                        aur
			echo "Setting up desktop entries for startx..."
                        startx
			echo -e "'\033[0;32m'Finished!! You can now reboot your machine.'\033[0m'"
			exit 69
			;;
	esac
done
