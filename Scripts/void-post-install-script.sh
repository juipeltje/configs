#!/bin/bash

# post install script for void linux
# NOTE TO SELF: MAKE SURE TO SETUP YOUR GIT ACCOUNT AND SSH KEY BEFORE RUNNING THIS SCRIPT!!

set -x

echo "starting void linux post install script..."

# update package manager

echo "updating package manager..."

xbps-install -uy xbps

# updating the system

echo "performing system update..."

xbps-install -Suy

# enabling additional repositories

echo "enabling additional repositories..."

xbps-install -Sy \
void-repo-multilib	\
void-repo-multilib-nonfree	\
void-repo-nonfree	

# installing packages

echo "installing packages..."

xbps-install -Sy \
  # display server and graphics drivers
xorg	\
vulkan-loader	\
mesa	\
mesa-32-bit	\
mesa-dri	\
mesa-dri-32bit	\
mesa-vaapi	\
mesa-vdpau	\
mesa-vulkan-radeon	\
mesa-vulkan-radeon-32bit	\
  # DE
qtile	\
dunst	\
rofi	\
alacritty	\
firefox	\
thunderbird	\
libreoffice	\
libreoffice-i18n-nl	\
libreoffice-i18n-en-US	\
pcmanfm	\
lxappearance	\
qt5ct	\
qt6ct	\
kvantum	\
i3lock-color	\
pavucontrol	\
network-manager-applet	\
blueman	\
papirus-folders	\
papirus-icon-theme	\
  # display manager/login tools
lightdm	\
lightdm-gtk3-greeter	\
lightdm-webkit2-greeter	\
elogind	\
dbus-elogind    \
dbus-elogind-libs       \
dbus-elogind-x11        \
  # Multimedia
pipewire	\
wireplumber	\
playerctl	\
kodi	\
mpv	\
feh	\
strawberry	\
qbittorrent	\
  # system tools
nano	\
socklog-void	\
wireguard-dkms	\
wireguard-tools	\
pass	\
pass-otp	\
neofetch	\
lm_sensors	\
unzip	\
tar	\
7zip	\
gparted	\
htop	\
git	\
perl	\
cronie	\
openrgb	\
corectrl	\
lxsession	\
NetworkManager	\
bluez	\
alsa-utils	\
xdg-user-dirs	\
xdotool	\
gvfs	\
fuse    \
fuse3   \
i2c-tools	\
  # gaming
wine	\
mono	\
wine-mono	\
steam	\
gamemode	\
MangoHud	\
PrismLauncher	\
openjdk17-jre	\
dolphin-emu	\
  # virtualization
qemu	\
libvirt	\
virt-manager	\
dnsmasq	\
iptables	\

# installing pip and python packages/dependencies

echo "installing pip and python packages/dependencies..."

xbps-install -Sy 	\
python3	\
python3-pip	\
python3-psutil	\
python3-setuptools	\
python3-usb	\
python3-crcmod	\
python3-hid	\
python3-docopt	\
python3-Pillow	\
python3-smbus	\
libusb	\
python3-setuptools

python -m venv /home/joppe/python-venv
/home/joppe/python-venv/bin/python -m pip install dbus-next
/home/joppe/python-venv/bin/python -m pip install liquidctl

# setting up permissions for liquidctl

echo "setting up permissions for liquidctl..."

cp /home/joppe/repos/configs/workstation/config-files/etc/udev/rules.d/71-liquidctl.rules /etc/udev/rules.d/

# creating user directories

echo "creating user directories..."

xdg-user-dirs-update


# setting up additional kernel modules for openrgb 

echo "setting up additional kernel modules for openrgb..."

touch /etc/modules-load.d/i2c.conf && echo "i2c-dev" >> /etc/modules-load.d/i2c.conf
touch /etc/modules-load.d/i2c-piix4.conf && echo "i2c-piix4" >> /etc/modules-load.d/i2c-piix4.conf

# creating additional groups and adding the user to it

echo "creating additional groups and adding the user to it..."

groupadd --system i2c
usermod -aG i2c,kvm,libvirt,bluetooth,socklog joppe

# setting up flatpak and flathub

echo "setting up flatpak and flathub..."

xbps-install -Sy flatpak 
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# setting up swapfile

echo "setting up swapfile..."

dd if=/dev/zero of=/swapfile bs=1M count=8k status=progress
chmod 0600 /swapfile
mkswap -U clear /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

# configure grub

echo "configuring grub..."

kernel parameters!!
theming?
update-grub

# git cloning configs from repo and symlinking them to directories

echo "git cloning configs from repo and copying them to directories..."

git clone git@github.com:juipeltje/configs.git
rm /home/joppe/.bashrc
ln -s /home/joppe/repos/configs/dotfiles/.bashrc /home/joppe/
ln -s /home/joppe/repos/configs/workstation/dotfiles/.Xresources /home/joppe
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/qtile/ /home/joppe/.config/
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/alacritty/ /home/joppe/.config/
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/rofi/ /home/joppe/.config/
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/dunst/ /home/joppe/.config/
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/picom/ /home/joppe/.config/
cp -r /home/joppe/repos/configs/workstation/config-files/etc/X11/xorg.conf.d /etc/X11/
cp -r /home/joppe/repos/configs/workstation/config-files/etc/pipewire /etc/
cp -rf /home/joppe/repos/configs/config-files/etc/lightdm/lightdm.conf /etc/lightdm/
cp -rf /home/joppe/repos/configs/config-files/etc/lightdm/lightdm-webkit2-greeter.conf /etc/lightdm/
cp -rf /home/joppe/repos/configs/config-files/etc/elogind /etc/

# installing fonts

echo "installing fonts..."

cp -r /home/joppe/repos/configs/config-files/usr/share/fonts/Mononoki-Nerd-Font /usr/share/fonts/
cp -r /home/joppe/repos/configs/config-files/usr/share/fonts/Ubuntu-Nerd-Font /usr/share/fonts/

# installing themes

echo "installing themes..."

cp -r /home/joppe/repos/configs/config-files/usr/share/themes/Gruvbox-Material-Dark /usr/share/themes/
cp -r /home/joppe/repos/configs/config-files/usr/share/themes/Nordic /usr/share/themes/
cp -r /home/joppe/repos/configs/config-files/usr/share/icons/capitaine-cursors-light /usr/share/icons/

# enabling runit services

echo "enabling runit services..."

ln -s /etc/sv/NetworkManager /var/service/
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/bluetoothd /var/service/
ln -s /etc/sv/ntpd /var/service/
ln -s /etc/sv/socklog-unix /var/service/
ln -s /etc/sv/nanoklogd /var/service/
ln -s /etc/sv/libvirtd /var/service/
ln -s /etc/sv/lightdm /var/service/
ln -s /etc/sv/cronie /var/service/
