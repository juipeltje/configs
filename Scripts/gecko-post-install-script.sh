#!/bin/bash

# post install script for gecko linux
# NOTE TO SELF: MAKE SURE TO SETUP YOUR SSH KEY AND IT'S PERMISSIONS TO 400 BEFORE RUNNING THIS SCRIPT!!

set -e

# Arrays

# repos=()

packages=(
	# "vulkan-loader"
	"Mesa-32bit"
	"Mesa-dri-32bit"
	# "mesa-vaapi"
	# "mesa-vdpau"
	"libvulkan_radeon"
	"libvulkan_radeon-32bit"
	"qtile"
	"dunst"
	"rofi"
	"alacritty"
	# "firefox"
	"MozillaThunderbird"
	"libreoffice-writer"
	"libreoffice-l10n-nl"
	"libreoffice-l10n-en"
	"pcmanfm"
	"lxappearance"
	"qt5ct"
	"qt6ct"
	"kvantum-manager"
	"pavucontrol"
	"NetworkManager-applet"
	"blueman"
	"papirus-folders"
	"papirus-icon-theme"
	# "pipewire"
	# "wireplumber"
	"pipewire-jack"
	"playerctl"
	"kodi"
	"mpv"
	"feh"
	"deadbeef"
	"deadbeef-plugin-mpris2"
	# "qbittorrent"
	"transmission-gtk"
	# "nano"
	# "wireguard-dkms"
	"wireguard-tools"
	"password-store"
	"pass-otp"
	"sensors"
	# "unzip"
	# "tar"
	# "xz"
	# "7zip"
	"gparted"
	"htop"
	# "curl"
	# "wget"
	"openssh"
	# "cronie"
	"lxsession"
	# "NetworkManager"
	# "bluez"
	# "alsa-utils"
	# "xdg-user-dirs"
	"xdotool"
	# "gvfs"
	# "fuse"
	# "fuse3"
	"wine"
	"wine-mono"
	"steam"
	"gamemode"
	"mangohud"
	"java-17-openjdk"
	"dolphin-emu"
	"qemu"
	"libvirt"
	"virt-manager"
	"dnsmasq"
	# "iptables"
	"nftables"
	"hyprland"
	"hyprpaper"
	"mako"
	"waybar"
	"greetd"
	"gtkgreet"
	# "python3-dbus-next"
	"fastfetch"
	"mint-y-icon-theme"
	"ucode-amd"
	"git"
	"xwayland"
	"xinit"
	"i3"
	"libqt5-qtwayland"
	"ranger"
	"opi"
)

desktop_packages=(
	"OpenRGB"
	"OpenRGB-udev-rules"
	"i2c-tools"
	"ddcutil-i2c-udev-rules"
)

laptop_packages=(
	# "tlp"
	"brightnessctl"
	"cronie"
)

OBS_packages=(
	"swayfx" 
	"nwg-look" 
	"tofi" 
	"prismlauncher" 
	"i3lock-color"
	"VSCodium"
	"swaylock-effects" 
)

# Functions

OBS_desktop() {
	zypper addrepo https://download.opensuse.org/repositories/home:darix:playground/openSUSE_Tumbleweed/home:darix:playground.repo
	zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Tumbleweed/home:Dead_Mozay.repo
	zypper --gpg-auto-import-keys refresh
	zypper install -y liquidctl corectrl
}

OBS() {
	zypper addrepo https://download.opensuse.org/repositories/home:smolsheep/openSUSE_Tumbleweed/home:smolsheep.repo
	zypper addrepo https://download.opensuse.org/repositories/home:getchoo/openSUSE_Tumbleweed/home:getchoo.repo
	zypper addrepo https://download.opensuse.org/repositories/home:bfein/openSUSE_Tumbleweed/home:bfein.repo
	zypper addrepo https://download.opensuse.org/repositories/home:kwk/openSUSE_Tumbleweed/home:kwk.repo
	zypper addrepo https://download.opensuse.org/repositories/home:mantarimay:sway/standard/home:mantarimay:sway.repo
	zypper --gpg-auto-import-keys refresh
	zypper install -y "${OBS_packages[@]}"
}

configs() {
	sudo -u $user git clone git@github.com:juipeltje/configs.git /home/$user/repos/configs
        rm /home/$user/.bashrc
        sudo -u $user ln -s /home/$user/repos/configs/dotfiles/.bashrc /home/$user/
	sudo -u $user ln -s /home/$user/repos/configs/dotfiles/.bash_profile /home/$user/
	sudo -u $user ln -s /home/$user/repos/configs/dotfiles/.xinitrc-i3 /home/$user/
	sudo -u $user ln -s /home/$user/repos/configs/dotfiles/.xinitrc-qtile /home/$user/
	cp -r /home/$user/repos/configs/config-files/etc/pipewire /etc/
}

configs_desktop() {
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/.Xresources /home/$user
	sudo -u $user mkdir -p /home/$user/.config
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/qtile /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/alacritty /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/rofi /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/dunst /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/picom /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/hypr /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/mako /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/i3 /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/sway /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/tofi /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/polybar /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/waybar /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/mpv /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/ranger /home/$user/.config/
	sudo -u $user mkdir -p /home/$user/.local/share
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotlocal/share/rofi /home/$user/.local/share/
	cp -rf /home/$user/repos/configs/workstation/config-files/etc/greetd /etc/
}

configs_laptop() {
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/.Xresources /home/$user
	sudo -u $user mkdir -p /home/$user/.config
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/qtile /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/alacritty /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/rofi /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/dunst /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/picom /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/hypr /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/mako /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/i3 /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/sway /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/tofi /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/polybar /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/waybar /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/mpv /home/$user/.config/
        sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/ranger /home/$user/.config/
	sudo -u $user mkdir -p /home/$user/.local/share
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotlocal/share/rofi /home/$user/.local/share/
	cp -r /home/$user/repos/configs/laptop/config-files/etc/X11/xorg.conf.d /etc/X11/
	cp -rf /home/$user/repos/configs/laptop/config-files/etc/greetd /etc/
	cp -f /home/$user/repos/configs/laptop/config-files/etc/tlp.conf /etc/
}

fonts_and_themes() {
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Mononoki.tar.xz -P /home/$user/Downloads/
	mkdir /home/$user/Downloads/Mononoki-Nerd-Font
	tar -xf /home/$user/Downloads/Mononoki.tar.xz -C /home/$user/Downloads/Mononoki-Nerd-Font
	cp -r /home/$user/Downloads/Mononoki-Nerd-Font /usr/share/fonts/
	rm -r /home/$user/Downloads/Mononoki-Nerd-Font
	rm -r /home/$user/Downloads/Mononoki.tar.xz
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Ubuntu.tar.xz -P /home/$user/Downloads/
	mkdir /home/$user/Downloads/Ubuntu-Nerd-Font
	tar -xf /home/$user/Downloads/Ubuntu.tar.xz -C /home/$user/Downloads/Ubuntu-Nerd-Font
	cp -r /home/$user/Downloads/Ubuntu-Nerd-Font /usr/share/fonts/
	rm -r /home/$user/Downloads/Ubuntu-Nerd-Font
	rm -r /home/$user/Downloads/Ubuntu.tar.xz
	git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk /home/$user/gruvbox-gtk
	cp -r /home/$user/gruvbox-gtk/themes/Gruvbox-Material-Dark /usr/share/themes/
	cp -r /home/$user/gruvbox-gtk/icons/Gruvbox-Material-Dark /usr/share/icons/
	rm -r /home/$user/gruvbox-gtk
	wget https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic.tar.xz -P /home/$user/Downloads/
	mkdir /home/$user/Downloads/Nordic
	tar -xf /home/$user/Downloads/Nordic.tar.xz -C /home/$user/Downloads/Nordic
	cp -r /home/$user/Downloads/Nordic /usr/share/themes/
	rm -r /home/$user/Downloads/Nordic
	rm -r /home/$user/Downloads/Nordic.tar.xz
	git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme /home/$user/tokyo
	cp -r /home/$user/tokyo/themes/Tokyonight-Dark-BL /usr/share/themes/Tokyonight-Dark
	cp -r /home/$user/tokyo/themes/Tokyonight-Storm-BL /usr/share/themes/Tokyonight-Storm
	rm -r /home/$user/tokyo
	wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C /usr/share/icons/	
}

services() {
	systemctl enable bluetooth
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
	wget https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/opensuse.tar -P /home/$user/Downloads
	mkdir /home/$user/Downloads/opensuse-grub-theme
	tar -xf /home/$user/Downloads/opensuse.tar -C /home/$user/Downloads/opensuse-grub-theme
	mkdir -p /boot/grub2/themes
	cp -r /home/$user/Downloads/opensuse-grub-theme /boot/grub2/themes/opensuse-git
	sed -i 's|GRUB_THEME=/boot/grub2/themes/openSUSE/theme.txt|GRUB_THEME=/boot/grub2/themes/opensuse-git/theme.txt|' /etc/default/grub
	rm -r /home/$user/Downloads/opensuse-grub-theme
	rm -r /home/$user/Downloads/opensuse.tar
	swap_uuid=$(cat /etc/fstab | tail -n2 | head -n1 | awk '{print $1}')
        swap_offset=$(filefrag -v /swapfile | head -n 4 | tail -n 1 | awk '{print $4}' | sed 's/\..//')
}

cleanup() {
	systemctl disable xdm.service 
	zypper rm -uy icewm icewm-default icewm-theme-branding lightdm liblightdm-gobject-1-0 lightdm-gtk-greeter \
	lightdm-gtk-greeter-branding-openSUSE lightdm-gtk-greeter-lang lightdm-lang hplip hplip-hpijs hplip-sane \
	hplip-udev-rules OpenPrintingPPDs-hpijs xterm-bin xterm-resize rxvt-unicode sax3 
	swapoff /dev/zram0
	systemctl disable --now zramswap.service
	zypper rm -uy systemd-zram-service
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
	echo "installing packages..."
	zypper --gpg-auto-import-keys refresh
	zypper dup -y
	zypper install -y "${packages[@]}"
	zypper install -y "${desktop_packages[@]}"
	echo "installing config files..."
	configs
	configs_desktop
	echo "installing fonts and themes..."
	fonts_and_themes
	cp -r /home/$user/repos/configs/workstation/config-files/etc/X11/xorg.conf.d /etc/X11/
	echo "adding user to groups..."
	usermod -aG kvm,libvirt $user
	echo "adding kernel modules to load on boot..."
	touch /etc/modules-load.d/i2c.conf && echo "i2c-dev" >> /etc/modules-load.d/i2c.conf
	touch /etc/modules-load.d/i2c-piix4.conf && echo "i2c-piix4" >> /etc/modules-load.d/i2c-piix4.conf
	echo "setting up swapfile..."
	dd if=/dev/zero of=/swapfile bs=1M count=48k status=progress
	swapfile
	echo "configuring grub..."
	grub
	sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash loglevel=0\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$swap_uuid resume_offset=$swap_offset amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=4\"/" /etc/default/grub
	sed -i 's/#GRUB_GFXMODE=640x480/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
	grub2-mkconfig -o /boot/grub2/grub.cfg
	echo "enabling systemd services..."
	services
	echo "removing unwanted packages..."
	cleanup
	systemctl disable tlp.service
	zypper rm -uy tlp tlp-rdw 
	echo "fixing potential ownership issues with the user's home folder..."
	chown -R $user /home/$user
	echo "Finished!! You can now reboot your machine."
elif [ $device -eq 2 ]
then
	echo "installing packages..."
	zypper --gpg-auto-import-keys refresh
        zypper dup -y
        zypper install -y "${packages[@]}"
        zypper install -y "${laptop_packages[@]}"
        echo "installing config files..."
        configs
        configs_laptop
        echo "installing fonts and themes..."
	fonts_and_themes
        echo "adding user to groups..."
        usermod -aG kvm,libvirt $user
        echo "setting up swapfile..."
        dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress
        swapfile
        echo "configuring grub..."
        grub
	sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash loglevel=0\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$swap_uuid resume_offset=$swap_offset amdgpu.ppfeaturemask=0xffffffff loglevel=4\"/" /etc/default/grub
	sed -i 's/#GRUB_GFXMODE=640x480/GRUB_GFXMODE=1920x1080x32,auto/' /etc/default/grub
	grub2-mkconfig -o /boot/grub2/grub.cfg
	echo "setting up battery script and crontab for auto-hibernate when battery is low..."
	cp /home/$user/repos/configs/Scripts/battery.sh /usr/local/sbin/
	crontab /home/$user/repos/configs/laptop/crontab.txt
        echo "enabling systemd services..."
        services
	laptop_services
	echo "removing unwanted packages..."
	cleanup
        echo "fixing potential ownership issues with the user's home folder..."
        chown -R $user /home/$user
        echo "Finished!! You can now reboot your machine."
elif [ $device -eq 3 ]
then
	echo "installing packages..."
	zypper --gpg-auto-import-keys refresh
        zypper dup -y
	zypper install -y "${packages[@]}"
        echo "installing config files..."
        configs
        configs_desktop
        echo "installing fonts and themes..."
	fonts_and_themes
        echo "adding user to groups..."
        usermod -aG kvm,libvirt $user
        echo "enabling systemd services..."
        services
	echo "removing unwanted packages..."
	cleanup
	systemctl disable tlp.service
        zypper rm -uy tlp tlp-rdw 
        echo "fixing potential ownership issues with the user's home folder..."
        chown -R $user /home/$user
        echo "Finished!! You can now reboot your machine."		
else
	echo "device number not found, exiting..."
	exit 69
fi
