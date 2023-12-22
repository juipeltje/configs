#!/bin/bash

# post install script for void linux
# NOTE TO SELF: MAKE SURE TO SETUP YOUR GIT ACCOUNT AND SSH KEY BEFORE RUNNING THIS SCRIPT!!

set -ex

# Arrays

repos=(
	# extra repos
        "void-repo-multilib"
        "void-repo-multilib-nonfree"
        "void-repo-nonfree"
)

packages=(
	# xorg and graphics drivers
	"xorg"
	"vulkan-loader"
	"mesa"
	"mesa-32bit"
	"mesa-dri"
	"mesa-dri-32bit"
	"mesa-vaapi"
	"mesa-vdpau"
	"mesa-vulkan-radeon"
	"mesa-vulkan-radeon-32bit"
	"qtile"
	"dunst"
	"rofi"
	"alacritty"
	"firefox"
	"thunderbird"
	"libreoffice"
	"libreoffice-i18n-nl"
	"libreoffice-i18n-en-US"
	"pcmanfm"
	"lxappearance"
	"qt5ct"
	"qt6ct"
	"kvantum"
	"i3lock-color"
	"pavucontrol"
	"network-manager-applet"
	"blueman"
	"papirus-folders"
	"papirus-icon-theme"
	"elogind"
	"pipewire"
	"wireplumber"
	"playerctl"
	"kodi"
	"mpv"
	"feh"
	"strawberry"
	"qbittorrent"
	"nano"
	"socklog-void"
	"wireguard-dkms"
	"wireguard-tools"
	"pass"
	"pass-otp"
	"lm_sensors"
	"unzip"
	"tar"
	"xz"
	"7zip"
	"gparted"
	"htop"
	"curl"
	"wget"
	"openssh"
	"cronie"
	"corectrl"
	"lxsession"
	"NetworkManager"
	"bluez"
	"alsa-utils"
	"xdg-user-dirs"
	"xdotool"
	"gvfs"
	"fuse"
	"fuse3"
	"wine"
	"mono"
	"wine-mono"
	"steam"
	"gamemode"
	"MangoHud"
	"PrismLauncher"
	"openjdk17-jre"
	"dolphin-emu"
	"qemu"
	"libvirt"
	"virt-manager"
	"dnsmasq"
	"iptables"
	"wayland"
	"swayfx"
	"nwg-look"
	"tofi"
	"mako"
	"Waybar"
	"greetd"
	"python3-dbus-next"
)

desktop_packages=(
	"openrgb"
	"i2c-tools"
)

laptop_packages=(
	"tlp"
	"brightnessctl"
)

src_packages=(
	"ubuntu-nerd-font-ttf" 
	"mononoki-nerd-font-ttf" 
	"nordic-gtk" 
	"gruvbox-material-gtk" 
	"tokyo-night-gtk" 
	"phinger-cursors" 
	"mint-y-icons" 
	"fastfetch"
)

# Functions

xbps_src() {
	sudo -u $user git clone --depth 1 https://github.com/void-linux/void-packages.git /home/$user/void-packages 
	cd /home/$user/void-packages
	sudo -u $user ./xbps-src binary-bootstrap
	sudo -u $user git clone git@github.com:juipeltje/void-templates.git /home/$user/repos/void-templates
	sudo -u $user cp -r /home/$user/repos/void-templates/srcpkgs/* /home/$user/void-packages/srcpkgs/
	sudo -u $user ./xbps-src pkg ubuntu-nerd-font-ttf
	sudo -u $user ./xbps-src pkg mononoki-nerd-font-ttf
	sudo -u $user ./xbps-src pkg nordic-gtk
	sudo -u $user ./xbps-src pkg gruvbox-material-gtk
	sudo -u $user ./xbps-src pkg tokyo-night-gtk
	sudo -u $user ./xbps-src pkg phinger-cursors
	sudo -u $user ./xbps-src pkg mint-y-icons
	sudo -u $user ./xbps-src pkg fastfetch
	xbps-install -R hostdir/binpkgs "${src_packages[@]}" -y
	cd
}

xbps_src_desktop() {
	cd /home/$user/void-packages
	sudo -u $user ./xbps-src pkg python3-colorlog
	sudo -u $user ./xbps-src pkg python3-hidapi
	sudo -u $user ./xbps-src pkg liquidctl
	xbps-install -R hostdir/binpkgs liquidctl -y
	cd
}

configs() {
	sudo -u $user git clone git@github.com:juipeltje/configs.git /home/$user/repos/configs
        rm /home/$user/.bashrc
	rm /home/$user/.bash_profile
        sudo -u $user ln -s /home/$user/repos/configs/dotfiles/.bashrc /home/$user/
	sudo -u $user ln -s /home/$user/repos/configs/dotfiles/.bash_profile /home/$user/
	sudo -u $user ln -s /home/$user/repos/configs/dotfiles/.xinitrc /home/$user/
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
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/sway /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/tofi /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/waybar /home/$user/.config/
	sudo -u $user mkdir -p /home/$user/.local/share
	sudo -u $user ln -s /home/$user/repos/configs/workstation/dotfiles/dotlocal/share/rofi /home/$user/.local/share/
	cp -rf /home/$user/repos/configs/workstation/config-files/etc/elogind /etc/
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
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/sway /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/tofi /home/$user/.config/
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotconfig/waybar /home/$user/.config/
	sudo -u $user mkdir -p /home/$user/.local/share
	sudo -u $user ln -s /home/$user/repos/configs/laptop/dotfiles/dotlocal/share/rofi /home/$user/.local/share/
	cp -r /home/$user/repos/configs/laptop/config-files/etc/X11/xorg.conf.d /etc/X11/
	cp -rf /home/$user/repos/configs/laptop/config-files/etc/elogind /etc/
}

pipewire() {
	mkdir  /etc/pipewire/pipewire.conf.d
	ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
	ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
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
	wget https://github.com/AdisonCavani/distro-grub-themes/raw/master/themes/void-linux.tar -P /home/$user/Downloads
	mkdir /home/$user/Downloads/void-grub-theme
	tar -xf /home/$user/Downloads/void-linux.tar -C /home/$user/Downloads/void-grub-theme
	mkdir /boot/grub/themes
	cp -r /home/$user/Downloads/void-grub-theme /boot/grub/themes/void
	echo 'GRUB_THEME="/boot/grub/themes/void/theme.txt"' >> /etc/default/grub
	rm -r /home/$user/Downloads/void-grub-theme
	rm -r /home/$user/Downloads/void-linux.tar
	swap_uuid=$(cat /etc/fstab | head -n1 | awk '{print $1}')
        swap_offset=$(filefrag -v /swapfile | head -n 4 | tail -n 1 | awk '{print $4}' | sed 's/\..//')
}

dbus() {
	sed -i 's/Exec=sway/Exec=dbus-run-session sway/' /usr/share/wayland-sessions/sway.desktop
	touch /usr/share/xsessions/qtile-startx.desktop
	echo "[Desktop Entry]" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Name=Qtile (startx)" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Comment=Qtile Session started with startx for regreet display manager" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Exec=startx" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Type=Application" >> /usr/share/xsessions/qtile-startx.desktop
	echo "Keywords=wm;tiling" >> /usr/share/xsessions/qtile-startx.desktop
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
	xbps-install -uy xbps
	xbps-install -Suy
	xbps-install -Sy "${repos[@]}"
	xbps-install -Sy "${packages[@]}"
	xbps-install -Sy "${desktop_packages[@]}"
	echo "installing xbps-src packages..."
	xbps_src
	xbps_src_desktop
	echo "creating user directories..."
	sudo -u $user xdg-user-dirs-update
	echo "installing config files..."
	configs
	configs_desktop
	cp -r /home/$user/repos/configs/workstation/config-files/etc/X11/xorg.conf.d /etc/X11/
	echo "configuring pipewire..."
	pipewire
	echo "adding user to groups..."
	usermod -aG i2c,kvm,libvirt,bluetooth,socklog $user
	echo "adding kernel modules to load on boot..."
	touch /etc/modules-load.d/i2c.conf && echo "i2c-dev" >> /etc/modules-load.d/i2c.conf
	touch /etc/modules-load.d/i2c-piix4.conf && echo "i2c-piix4" >> /etc/modules-load.d/i2c-piix4.conf
	echo "setting up swapfile..."
	dd if=/dev/zero of=/swapfile bs=1M count=48k status=progress
	swapfile
	echo "configuring grub..."
	grub
	sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"loglevel=4\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$swap_uuid resume_offset=$swap_offset amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=4\"/" /etc/default/grub
	sed -i 's/#GRUB_GFXMODE=1920x1080x32/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
	update-grub
	echo "setting up weekly cronjob for SSD trimming..."
	cp /home/$user/repos/configs/Scripts/fstrim.sh /etc/cron.weekly/
	echo "enabling runit services..."
	services
	echo "fixing potential ownership issues with the user's home folder..."
	chown -R $user /home/$user
	echo "fixing dbus issues with window manager sessions..."
	dbus
	echo "Finished!! You can now reboot your machine."
elif [ $device -eq 2 ]
then
	echo "installing packages..."
        xbps-install -uy xbps
        xbps-install -Suy
	xbps-install -Sy "${repos[@]}"
        xbps-install -Sy "${packages[@]}"
        xbps-install -Sy "${laptop_packages[@]}"
        echo "installing xbps-src packages..."
        xbps_src
        echo "creating user directories..."
        sudo -u $user xdg-user-dirs-update
        echo "installing config files..."
        configs
        configs_laptop
        echo "configuring pipewire..."
        pipewire
        echo "adding user to groups..."
        usermod -aG kvm,libvirt,bluetooth,socklog $user
        echo "setting up swapfile..."
        dd if=/dev/zero of=/swapfile bs=1M count=24k status=progress
        swapfile
        echo "configuring grub..."
        grub
	sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"loglevel=4\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$swap_uuid resume_offset=$swap_offset amdgpu.ppfeaturemask=0xffffffff loglevel=4\"/" /etc/default/grub
	update-grub
        echo "setting up weekly cronjob for SSD trimming..."
        cp /home/$user/repos/configs/Scripts/fstrim.sh /etc/cron.weekly/
	echo "setting up battery script and crontab for auto-hibernate when battery is low..."
	cp /home/$user/repos/configs/Scripts/battery.sh /usr/local/sbin/
	crontab /home/$user/repos/configs/laptop/crontab.txt
        echo "enabling runit services..."
        services
	laptop_services
        echo "fixing potential ownership issues with the user's home folder..."
        chown -R $user /home/$user
	echo "fixing dbus issues with window manager sessions..."
        dbus
        echo "Finished!! You can now reboot your machine."
elif [ $device -eq 3 ]
then
	echo "installing packages..."
        xbps-install -uy xbps
        xbps-install -Suy
	xbps-install -Sy "${repos[@]}"
        xbps-install -Sy "${packages[@]}"
        echo "installing xbps-src packages..."
        xbps_src
        echo "creating user directories..."
        sudo -u $user xdg-user-dirs-update
        echo "installing config files..."
        configs
        configs_desktop
        echo "configuring pipewire..."
        pipewire
        echo "adding user to groups..."
        usermod -aG kvm,libvirt,bluetooth,socklog $user
        echo "enabling runit services..."
        services
        echo "fixing potential ownership issues with the user's home folder..."
        chown -R $user /home/$user
	echo "fixing dbus issues with window manager sessions..."
        dbus
        echo "Finished!! You can now reboot your machine."		
else
	echo "device number not found, exiting..."
	exit 69
fi
