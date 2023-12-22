#!/bin/bash

# post install script for void linux
# NOTE TO SELF: MAKE SURE TO SETUP YOUR GIT ACCOUNT AND SSH KEY BEFORE RUNNING THIS SCRIPT!!

set -e

# Variables

user="joppe"

# start post-install script

echo "starting void linux post install script..."

# update package manager

echo "updating package manager..."

xbps-install -Suy xbps

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
xorg	\
vulkan-loader	\
mesa	\
mesa-32bit	\
mesa-dri	\
mesa-dri-32bit	\
mesa-vaapi	\
mesa-vdpau	\
mesa-vulkan-radeon	\
mesa-vulkan-radeon-32bit	\
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
elogind	\
pipewire	\
wireplumber	\
playerctl	\
kodi	\
mpv	\
feh	\
strawberry	\
qbittorrent	\
nano	\
socklog-void	\
wireguard-dkms	\
wireguard-tools	\
pass	\
pass-otp	\
lm_sensors	\
unzip	\
tar	\
xz	\
7zip	\
gparted	\
htop	\
curl	\
wget	\
openssh	\
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
wine	\
mono	\
wine-mono	\
steam	\
gamemode	\
MangoHud	\
PrismLauncher	\
openjdk17-jre	\
dolphin-emu	\
qemu	\
libvirt	\
virt-manager	\
dnsmasq	\
iptables
wayland \
swayfx  \
nwg-look        \
tofi    \
mako    \
Waybar  \
greetd

# setting up xbps-src

echo "setting up xbps-src..."

sudo -u $user git clone https://github.com/void-linux/void-packages.git /home/$user/void-packages

cd /home/$user/void-packages

sudo -u $user ./xbps-src binary-bootstrap

cd

# build and install packages from template repo?

# creating user directories

echo "creating user directories..."

xdg-user-dirs-update

# adding the user to additional groups

echo "adding the user to additional groups..."

usermod -aG kvm,libvirt,bluetooth,socklog $user

# setting up flatpak and flathub

echo "setting up flatpak and flathub..."

xbps-install -Sy flatpak
 
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# configure grub

echo "configuring grub..."

sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4"/GRUB_CMDLINE_LINUX_DEFAULT="amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=4"/' /etc/default/grub

sed -i 's/#GRUB_GFXMODE=1920x1080x32/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub

wget https://github.com/AdisonCavani/distro-grub-themes/raw/master/themes/void-linux.tar -P /home/$user/Downloads

mkdir /home/$user/Downloads/void-grub-theme

tar -xvf /home/$user/Downloads/void-linux.tar -C /home/$user/Downloads/void-grub-theme

mkdir /boot/grub/themes

cp -r /home/$user/Downloads/void-grub-theme /boot/grub/themes/void

echo 'GRUB_THEME="/boot/grub/themes/void/theme.txt"' >> /etc/default/grub

update-grub

# git cloning configs from repo and symlinking them to directories

echo "git cloning configs from repo and copying them to directories..."

sudo -u $user mkdir /home/$user/repos

sudo -u $user git clone git@github.com:juipeltje/configs.git /home/$user/repos/configs

rm /home/$user/.bashrc

ln -s /home/$user/repos/configs/dotfiles/.bashrc /home/$user/

ln -s /home/$user/repos/configs/workstation/dotfiles/.Xresources /home/$user

mkdir /home/$user/.config

ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/qtile/ /home/$user/.config/

ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/alacritty/ /home/$user/.config/

ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/rofi/ /home/$user/.config/

ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/dunst/ /home/$user/.config/

ln -s /home/$user/repos/configs/workstation/dotfiles/dotconfig/picom/ /home/$user/.config/

mkdir -p /home/$user/.local/share

ln -s /home/$user/repos/configs/workstation/dotfiles/dotlocal/share/rofi /home/$user/.local/share/

cp -r /home/$user/repos/configs/config-files/etc/pipewire /etc/

# cp -rf /home/$user/repos/configs/config-files/etc/lightdm/lightdm.conf /etc/lightdm/

# cp -rf /home/$user/repos/configs/config-files/etc/lightdm/lightdm-webkit2-greeter.conf /etc/lightdm/

cp -rf /home/$user/repos/configs/workstation/config-files/etc/elogind /etc/

# enabling runit services

echo "enabling runit services..."

ln -s /etc/sv/NetworkManager /var/service/

ln -s /etc/sv/dbus /var/service/

ln -s /etc/sv/bluetoothd /var/service/

ln -s /etc/sv/ntpd /var/service/

ln -s /etc/sv/socklog-unix /var/service/

ln -s /etc/sv/nanoklogd /var/service/

ln -s /etc/sv/libvirtd /var/service/

ln -s /etc/sv/cronie /var/service/

# ln -s /etc/sv/greetd /var/service/

# fixing any ownership issues for the user's home folder

echo "fixing any ownership issues for the user's home folder..."

chown -R $user /home/$user

# add dbus commands to .desktop files?

# end of post-instal script

echo "Finished!! You can now reboot your machine."
