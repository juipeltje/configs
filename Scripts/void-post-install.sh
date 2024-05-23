#!/bin/bash

# post install script for void linux

set -e

# Variables
color_reset="\033[0m"
green="\033[0;32m"
red="\033[0;31m"
bright_green="\033[0;92m"
PS3=$'\e[0;92m'"->"$'\e[m'

# Arrays

repos=(
	# extra repos
        "void-repo-multilib"
        "void-repo-multilib-nonfree"
        "void-repo-nonfree"
)

packages=(
        # Xorg/Window managers
        "xorg-minimal"
        "xf86-video-amdgpu"
        "xdotool"
        "i3"
        "qtile"
	"python3-dbus-next"

        # Wayland/Compositors
        "swayfx"
        "xorg-server-xwayland"

        # Greeter
        "greetd"

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
        "steam"
        "gamemode"
	"MangoHud"
        "MangoHud-32bit"
        "dolphin-emu"
	"PrismLauncher"
        "openjdk17-jre"

        # Networking
	"NetworkManager"
        "network-manager-applet"
        "openssh"
	"wireguard-dkms"
        "wireguard-tools"
        "transmission-gtk"

        # Bluetooth
        "bluez"
        "blueman"

        # Terminal
        "alacritty"

        # Webbrowser
        "firefox"

        # File managers/utilities
        "pcmanfm"
	"xz"
        "unzip"
        "7zip"
        "gvfs"
        "fuse3"

        # E-mail
        "thunderbird"

	# Office
	"libreoffice"
        "libreoffice-i18n-nl"
        "libreoffice-i18n-en-US"

        # Notifications
        "dunst"
        "mako"
        "libnotify"

        # Run launchers
        "rofi"
        "wofi"

        # Status bars
        "polybar"
        "Waybar"

        # Multimedia
	"pipewire"
        "wireplumber"
        "alsa-utils"
        "pavucontrol"
        "playerctl"
        "mpv"
	"kodi"
        "feh"

        # Theming/Fonts
        "lxappearance"
        "nwg-look"
        "qt5ct"
        "qt6ct"
        "kvantum"
        "papirus-icon-theme"
	"papirus-folders"

        # Benchmarking
        "python3-s-tui"
        "stress-ng"

        # Other
        "git"
        "lm_sensors"
        "pass"
        "pass-otp"
        "gparted"
        "wget"
        "lxsession"
        "nano"
        "vscode"
        "htop"
        "xdg-user-dirs"
	"elogind"
        "socklog-void"
        "cronie"
	"curl"
)

desktop_packages=(
	# RGB
	"openrgb"
	"i2c-tools"

	# Virtualisation
        "qemu"
        "libvirt"
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

src_packages=(
	"ubuntu-nerd-font-ttf"
        "mononoki-nerd-font-ttf"
        "nordic-gtk"
        "gruvbox-material-gtk"
        # "tokyo-night-gtk"
        "phinger-cursors"
        "mint-y-icons"
        "fastfetch"
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

xbps_src() {
	sudo -u ${user} git clone --depth 1 https://github.com/void-linux/void-packages.git /home/${user}/void-packages
        cd /home/${user}/void-packages
        sudo -u ${user} ./xbps-src binary-bootstrap
        sudo -u ${user} git clone https://github.com/juipeltje/void-templates /home/$user/void-templates
        sudo -u ${user} cp -r /home/$user/void-templates/srcpkgs/* /home/$user/void-packages/srcpkgs/
        sudo -u ${user} ./xbps-src pkg ubuntu-nerd-font-ttf
        sudo -u ${user} ./xbps-src pkg mononoki-nerd-font-ttf
        sudo -u ${user} ./xbps-src pkg nordic-gtk
        sudo -u ${user} ./xbps-src pkg gruvbox-material-gtk
        # sudo -u ${user} ./xbps-src pkg tokyo-night-gtk
        sudo -u ${user} ./xbps-src pkg phinger-cursors
        sudo -u ${user} ./xbps-src pkg mint-y-icons
        sudo -u ${user} ./xbps-src pkg fastfetch
        xbps-install -R hostdir/binpkgs "${src_packages[@]}" -y
        cd
}

xbps_src_desktop() {
	cd /home/${user}/void-packages
        sudo -u ${user} ./xbps-src pkg python3-colorlog
        sudo -u ${user} ./xbps-src pkg python3-hidapi
        sudo -u ${user} ./xbps-src pkg liquidctl
        xbps-install -R hostdir/binpkgs liquidctl -y
        cd
}

services() {
	ln -s /etc/sv/NetworkManager /var/service/
        ln -s /etc/sv/dbus /var/service/
        ln -s /etc/sv/bluetoothd /var/service/
        ln -s /etc/sv/ntpd /var/service/
        ln -s /etc/sv/socklog-unix /var/service/
        ln -s /etc/sv/nanoklogd /var/service/
        ln -s /etc/sv/libvirtd /var/service/
        ln -s /etc/sv/cronie /var/service/
}

laptop_services() {
	ln -s /etc/sv/tlp /var/service/
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
	rm -r /home/${user}/Downloads/void-grub-theme
	rm -r /home/${user}/Downloads/void-linux.tar
	swap_uuid=$(cat /etc/fstab | head -n1 | awk '{print $1}')
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
	sudo -u ${user} cp -f /home/${user}/configs/common/home/.bash_profile /home/${user}/
	sudo -u ${user} cp -f /home/${user}/configs/common/home/.xinitrc-i3 /home/${user}/
	sudo -u ${user} cp -f /home/${user}/configs/common/home/.xinitrc-qtile /home/${user}/
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
	cp -rf /home/${user}/configs/workstation/etc/elogind /etc/
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
	cp -rf /home/${user}/configs/laptop/etc/elogind /etc/
}

pipewire() {
	mkdir -p /etc/pipewire/pipewire.conf.d
        ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
        ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
}

desktop_entries() {
	echo "[Desktop Entry]" > /usr/share/xsessions/qtile-startx.desktop
	echo "Name=Qtile (startx)" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Comment=Qtile session started with startx for regreet display manager" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Exec=dbus-run-session startx ~/.xinitrc-qtile" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Type=Application" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Keywords=wm;tiling" >> /usr/share/xsessions/qtile-startx.desktop

	echo "[Desktop Entry]" > /usr/share/xsessions/i3-startx.desktop
	echo "Name=i3 (startx)" >> /usr/share/xsessions/i3-startx.desktop
	echo "Comment=i3 session started with startx for regreet display manager" >> /usr/share/xsessions/i3-startx.desktop
	echo "Exec=dbus-run-session startx ~/.xinitrc-i3" >> /usr/share/xsessions/i3-startx.desktop
	echo "Type=Application" >> /usr/share/xsessions/i3-startx.desktop
	echo "Keywords=wm;tiling" >> /usr/share/xsessions/i3-startx.desktop

	echo "[Desktop Entry]" > /usr/share/wayland-sessions/sway-dbus.desktop
	echo "Name=SwayFX (dbus)" >> /usr/share/wayland-sessions/sway-dbus.desktop
	echo "Comment=Swayfx session started with dbus for void linux" >> /usr/share/wayland-sessions/sway-dbus.desktop
	echo "Exec=dbus-run-session sway" >> /usr/share/wayland-sessions/sway-dbus.desktop
	echo "Type=Application" >> /usr/share/wayland-sessions/sway-dbus.desktop
	echo "Keywords=wm;tiling" >> /usr/share/wayland-sessions/sway-dbus.desktop

	echo "[Desktop Entry]" > /usr/share/wayland-sessions/hyprland-dbus.desktop
	echo "Name=Hyprland (dbus)" >> /usr/share/wayland-sessions/hyprland-dbus.desktop
	echo "Comment=Hyprland session started with dbus for void linux" >> /usr/share/wayland-sessions/hyprland-dbus.desktop
	echo "Exec=dbus-run-session Hyprland" >> /usr/share/wayland-sessions/hyprland-dbus.desktop
	echo "Type=Application" >> /usr/share/wayland-sessions/hyprland-dbus.desktop
	echo "Keywords=wm;tiling" >> /usr/share/wayland-sessions/hyprland-dbus.desktop
}

echo -e "${bright_green}This script will install both global system configurations as well as dotfiles in the user's home folder.
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

			# Install packages
			echo -e "${bright_green}Installing packages...${color_reset}"
			xbps-install -uy xbps
        		xbps-install -Suy
        		xbps-install -Sy "${repos[@]}"
        		xbps-install -Sy "${packages[@]}"
        		xbps-install -Sy "${desktop_packages[@]}"
        		echo -e "${bright_green}installing xbps-src packages...${color_reset}"
        		xbps_src
        		xbps_src_desktop

			# Create user directories
			echo -e "${bright_green}Creating user directories...${color_reset}"
			sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${bright_green}Installing config files...${color_reset}"
			rm_default_configs
			configs
			configs_desktop
			cp -rf /home/${user}/configs/workstation/etc/X11/xorg.conf.d /etc/X11/

			# Pipewire
			echo -e "${bright_green}configuring pipewire...${color_reset}"
        		pipewire

			# Add user to groups
			echo -e "${bright_green}Adding user to groups...${color_reset}"
			usermod -aG i2c,kvm,libvirt,bluetooth,socklog ${user}

			# Kernel modules
			echo -e "${bright_green}Adding kernel modules to load on boot...${color_reset}"
        		echo "i2c-dev" > /etc/modules-load.d/i2c.conf
        		echo "i2c-piix4" > /etc/modules-load.d/i2c-piix4.conf
        		echo "options vfio-pci ids=10de:1287,10de:0e0f" > /etc/modprobe.d/vfio.conf
			echo -e "force_drivers+=\" vfio_pci vfio vfio_iommu_type1 \"" > /etc/dracut.conf.d/10-vfio.conf
        		dracut --force

			# Swap
			echo -e "${bright_green}Setting up swapfile...${color_reset}"
			dd if=/dev/zero of=/swapfile bs=1M count=48k status=progress
			swapfile

			# Grub
			echo -e "${bright_green}Configuring grub...${color_reset}"
        		grub
        		sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=${swap_uuid} resume_offset=${swap_offset} amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=4\"/" /etc/default/grub
        		sed -i 's/^#GRUB_GFXMODE.*/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
        		update-grub

			# SSD trim
			echo -e "${bright_green}setting up weekly cronjob for SSD trimming...${color_reset}"
        		cp /home/${user}/configs/Scripts/fstrim.sh /etc/cron.weekly/

			# Services
			echo -e "${bright_green}Enabling runit services...${color_reset}"
        		services

			# Desktop entries
			echo -e "${bright_green}Setting up desktop entries...${color_reset}"
			desktop_entries

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		"laptop")
			echo -e "${bright_green}Continuing post-install script with settings for laptop...${color_reset}"

			# Install packages
			echo -e "${bright_green}Installing packages...${color_reset}"
			xbps-install -uy xbps
        		xbps-install -Suy
        		xbps-install -Sy "${repos[@]}"
        		xbps-install -Sy "${packages[@]}"
        		xbps-install -Sy "${laptop_packages[@]}"
        		echo -e "${bright_green}installing xbps-src packages...${color_reset}"
        		xbps_src

			# Create user directories
			echo -e "${bright_green}Creating user directories...${color_reset}"
                        sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${bright_green}Installing config files...${color_reset}"
                        rm_default_configs
                        configs
			configs_laptop

			# Pipewire
                        echo -e "${bright_green}configuring pipewire...${color_reset}"
                        pipewire

			# Add user to groups
			echo -e "${bright_green}Adding user to groups...${color_reset}"
        		usermod -aG bluetooth,socklog ${user}

			# Swap
			echo -e "${bright_green}Setting up swapfile...${color_reset}"
			dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress
			swapfile

			# Grub
			echo -e "${bright_green}Configuring grub...${color_reset}"
        		grub
        		sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT.*/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=${swap_uuid} resume_offset=${swap_offset} amdgpu.ppfeaturemask=0xffffffff loglevel=4\"/" /etc/default/grub
        		update-grub

			# SSD trim
                        echo -e "${bright_green}setting up weekly cronjob for SSD trimming...${color_reset}"
                        cp /home/${user}/configs/Scripts/fstrim.sh /etc/cron.weekly/

			# Battery
			echo -e "${bright_green}Setting up battery script and crontab for auto-hibernate when battery is low...${color_reset}"
			cp /home/${user}/configs/Scripts/battery.sh /usr/local/sbin/
        		crontab /home/${user}/configs/laptop/crontab.txt

			# Services
			echo -e "${bright_green}Enabling runit services...${color_reset}"
        		services
        		laptop_services

			# Desktop entries
			echo -e "${bright_green}Setting up desktop entries...${color_reset}"
                        desktop_entries

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		"virtual machine")
			echo -e "${bright_green}Continuing post-install script with settings for virtual machine...${color_reset}"

			# Install packages
			echo -e "${bright_green}Installing packages...${color_reset}"
			xbps-install -uy xbps
        		xbps-install -Suy
        		xbps-install -Sy "${repos[@]}"
        		xbps-install -Sy "${packages[@]}"
        		echo -e "${bright_green}installing xbps-src packages...${color_reset}"
        		xbps_src

			# Create user directories
			echo -e "${bright_green}Creating user directories...${color_reset}"
                        sudo -u ${user} xdg-user-dirs-update

			# Install config files
			echo -e "${bright_green}Installing config files...${color_reset}"
                        rm_default_configs
                        configs
                        configs_desktop

			# Pipewire
                        echo -e "${bright_green}configuring pipewire...${color_reset}"
                        pipewire

			# Add user to groups
			echo -e "${bright_green}Adding user to groups...${color_reset}"
			usermod -aG bluetooth,socklog ${user}

			# Services
			echo -e "${bright_green}Enabling runit services...${color_reset}"
        		services

			# Desktop entries
			echo -e "${bright_green}Setting up desktop entries...${color_reset}"
                        desktop_entries

			echo -e "${green}Finished!! You can now reboot your machine.${color_reset}"
			exit 69
			;;
		*)
			echo -e "${red}Invalid option, please try again.${color_reset}"
			;;
	esac
done
