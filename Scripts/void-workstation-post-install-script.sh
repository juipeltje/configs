#!/bin/bash

# post install script for void linux
# NOTE TO SELF: MAKE SURE TO SETUP YOUR GIT ACCOUNT AND SSH KEY BEFORE RUNNING THIS SCRIPT!!

set -e

echo "starting void linux post install script..."
sleep 2

# update package manager

echo "updating package manager..."
sleep 2
xbps-install -Suy xbps

# updating the system

echo "performing system update..."
sleep 2
xbps-install -Suy

# enabling additional repositories

echo "enabling additional repositories..."
sleep 2
xbps-install -Sy \
void-repo-multilib	\
void-repo-multilib-nonfree	\
void-repo-nonfree	

# installing packages

echo "installing packages..."
sleep 2
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
lightdm	\
lightdm-gtk3-greeter	\
lightdm-webkit2-greeter	\
elogind	\
dbus-elogind    \
dbus-elogind-libs       \
dbus-elogind-x11        \
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
neofetch	\
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

# setting up xbps-src

echo "setting up xbps-src..."
sleep 2
sudo -u joppe git clone https://github.com/void-linux/void-packages.git /home/joppe/void-packages
sleep 1
cd /home/joppe/void-packages
sleep 1
sudo -u joppe ./xbps-src binary-bootstrap
sleep 1
cd

# installing pip and python packages/dependencies

echo "installing pip and python packages/dependencies..."
sleep 2
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
python3-setuptools	\
python3-devel
sleep 1
sudo -u joppe pip install dbus-next
sleep 1
sudo -u joppe pip install liquidctl

# creating user directories

echo "creating user directories..."
sleep 2
xdg-user-dirs-update


# setting up additional kernel modules for openrgb 

echo "setting up additional kernel modules for openrgb..."
sleep 2
touch /etc/modules-load.d/i2c.conf && echo "i2c-dev" >> /etc/modules-load.d/i2c.conf
sleep 1
touch /etc/modules-load.d/i2c-piix4.conf && echo "i2c-piix4" >> /etc/modules-load.d/i2c-piix4.conf

# adding the user to additional groups

echo "adding the user to additional groups..."
sleep 2
usermod -aG i2c,kvm,libvirt,bluetooth,socklog joppe

# setting up flatpak and flathub

echo "setting up flatpak and flathub..."
sleep 2
xbps-install -Sy flatpak
sleep 1 
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# setting up swapfile

echo "setting up swapfile..."
sleep 2
dd if=/dev/zero of=/swapfile bs=1M count=8k status=progress
sleep 1
chmod 0600 /swapfile
sleep 1
mkswap -U clear /swapfile
sleep 1
swapon /swapfile
sleep 1
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

# configure grub

echo "configuring grub..."
sleep 2
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4"/GRUB_CMDLINE_LINUX_DEFAULT="amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=4"/' /etc/default/grub
sleep 1
sed -i 's/#GRUB_GFXMODE=1920x1080x32/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
sleep 1
wget https://github.com/AdisonCavani/distro-grub-themes/raw/master/themes/void-linux.tar -P /home/joppe/Downloads
sleep 1
mkdir /home/joppe/Downloads/void-grub-theme
sleep 1
tar -xvf /home/joppe/Downloads/void-linux.tar -C /home/joppe/Downloads/void-grub-theme
sleep 1
mkdir /boot/grub/themes
sleep 1
cp -r /home/joppe/Downloads/void-grub-theme /boot/grub/themes/void
sleep 1
echo 'GRUB_THEME="/boot/grub/themes/void/theme.txt"' >> /etc/default/grub
sleep 1
update-grub

# git cloning configs from repo and symlinking them to directories

echo "git cloning configs from repo and copying them to directories..."
sleep 2
sudo -u joppe mkdir /home/joppe/repos
sleep 1
sudo -u joppe git clone git@github.com:juipeltje/configs.git /home/joppe/repos/configs
sleep 1
rm /home/joppe/.bashrc
sleep 1
ln -s /home/joppe/repos/configs/dotfiles/.bashrc /home/joppe/
sleep 1
ln -s /home/joppe/repos/configs/workstation/dotfiles/.Xresources /home/joppe
sleep 1
mkdir /home/joppe/.config
sleep 1
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/qtile/ /home/joppe/.config/
sleep 1
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/alacritty/ /home/joppe/.config/
sleep 1
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/rofi/ /home/joppe/.config/
sleep 1
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/dunst/ /home/joppe/.config/
sleep 1
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotconfig/picom/ /home/joppe/.config/
sleep 1
mkdir -p /home/joppe/.local/share
sleep 1
ln -s /home/joppe/repos/configs/workstation/dotfiles/dotlocal/share/rofi /home/joppe/.local/share/
sleep 1
cp -r /home/joppe/repos/configs/workstation/config-files/etc/X11/xorg.conf.d /etc/X11/
sleep 1
cp -r /home/joppe/repos/configs/config-files/etc/pipewire /etc/
sleep 1
cp -rf /home/joppe/repos/configs/config-files/etc/lightdm/lightdm.conf /etc/lightdm/
sleep 1
cp -rf /home/joppe/repos/configs/config-files/etc/lightdm/lightdm-webkit2-greeter.conf /etc/lightdm/
sleep 1
cp -rf /home/joppe/repos/configs/workstation/config-files/etc/elogind /etc/

# installing fonts

echo "installing fonts..."
sleep 2
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip -P /home/joppe/Downloads/
sleep 1
mkdir /home/joppe/Downloads/Mononoki-Nerd-Font
sleep 1
unzip /home/joppe/Downloads/Mononoki.zip -d /home/joppe/Downloads/Mononoki-Nerd-Font/
sleep 1
cp -r /home/joppe/Downloads/Mononoki-Nerd-Font /usr/share/fonts/
sleep 1
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Ubuntu.zip -P /home/joppe/Downloads/
sleep 1
mkdir /home/joppe/Downloads/Ubuntu-Nerd-Font 
sleep 1
unzip /home/joppe/Downloads/Ubuntu.zip -d /home/joppe/Downloads/Ubuntu-Nerd-Font/
sleep 1
cp -r /home/joppe/Downloads/Ubuntu-Nerd-Font /usr/share/fonts/

# installing themes

echo "installing themes..."
sleep 2
wget https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic.tar.xz -P /home/joppe/Downloads
sleep 1
tar -xvf /home/joppe/Downloads/Nordic.tar.xz -C /home/joppe/Downloads
sleep 1
cp -r /home/joppe/Downloads/Nordic /usr/share/themes
sleep 1
mkdir /home/joppe/.local/share/themes
sleep 1
cp -r /home/joppe/Downloads/Nordic /home/joppe/.local/share/themes/
sleep 1
mkdir -p /home/joppe/kvantum-themes/Nordic
sleep 1
wget https://raw.githubusercontent.com/EliverLara/Nordic/master/kde/kvantum/Nordic/Nordic.kvconfig -P /home/joppe/kvantum-themes/Nordic/
sleep 1
wget https://raw.githubusercontent.com/EliverLara/Nordic/master/kde/kvantum/Nordic/Nordic.svg -P /home/joppe/kvantum-themes/Nordic/
sleep 1
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk /home/joppe/gruvbox-material-gtk
sleep 1
cp -r /home/joppe/gruvbox-material-gtk/themes/Gruvbox-Material-Dark /usr/share/themes/
sleep 1
cp -r /home/joppe/gruvbox-material-gtk/themes/Gruvbox-Material-Dark /home/joppe/.local/share/themes/
sleep 1
cp -r /home/joppe/gruvbox-material-gtk/icons/Gruvbox-Material-Dark /usr/share/icons/
sleep 1
mkdir /home/joppe/.local/share/icons
sleep 1
cp -r /home/joppe/gruvbox-material-gtk/icons/Gruvbox-Material-Dark /home/joppe/.local/share/icons/
sleep 1
wget https://github.com/theglitchh/Gruvbox-Kvantum/releases/download/v1.1/gruvbox-kvantum-v1.1.zip -P /home/joppe/Downloads
sleep 1
unzip /home/joppe/Downloads/gruvbox-kvantum-v1.1.zip -d /home/joppe/kvantum-themes/
sleep 1
cp -r /home/joppe/repos/configs/config-files/usr/share/icons/capitaine-cursors-light /usr/share/icons/
sleep 1
wget https://github.com/eromatiya/lightdm-webkit2-theme-glorious/releases/download/v2.0.5/lightdm-webkit2-theme-glorious-2.0.5.tar.gz -P /home/joppe/Downloads/
sleep 1
mkdir /home/joppe/Downloads/lightdm-webkit2-theme-glorious
sleep 1
tar -xvf /home/joppe/Downloads/lightdm-webkit2-theme-glorious-2.0.5.tar.gz -C /home/joppe/Downloads/lightdm-webkit2-theme-glorious/
sleep 1
cp -r /home/joppe/Downloads/lightdm-webkit2-theme-glorious /usr/share/lightdm-webkit/themes/glorious

# setting up permissions for liquidctl

echo "setting up permissions for liquidctl..."
sleep 2
wget https://raw.githubusercontent.com/liquidctl/liquidctl/main/extra/linux/71-liquidctl.rules -P /etc/udev/rules.d/

# setting up weekly cronjob for SSD trimming

echo "setting up weekly cronjob for SSD trimming..."
sleep 2
cp /home/joppe/repos/configs/Scripts/fstrim.sh /etc/cron.weekly/

# enabling runit services

echo "enabling runit services..."
sleep 2
ln -s /etc/sv/NetworkManager /var/service/
sleep 1
ln -s /etc/sv/dbus /var/service/
sleep 1
ln -s /etc/sv/bluetoothd /var/service/
sleep 1
ln -s /etc/sv/ntpd /var/service/
sleep 1
ln -s /etc/sv/socklog-unix /var/service/
sleep 1
ln -s /etc/sv/nanoklogd /var/service/
sleep 1
ln -s /etc/sv/libvirtd /var/service/
sleep 1
ln -s /etc/sv/cronie /var/service/
sleep 1
ln -s /etc/sv/lightdm /var/service/

# fixing any ownership issues for the user's home folder

echo "fixing any ownership issues for the user's home folder..."
sleep 2
chown -R joppe /home/joppe

# fixing dbus issues in window manager session

echo "fixing dbus issues in window manager session..."
sleep 2
sed -i 's/Exec=qtile start/Exec=dbus-launch --exit-with-session qtile start/' /usr/share/xsessions/qtile.desktop

echo "Finished!! You can now reboot your machine."
