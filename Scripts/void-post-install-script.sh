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
xz	\
7zip	\
gparted	\
htop	\
perl	\
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

# setting up xbps-src

echo "setting up xbps-src..."

git clone https://github.com/void-linux/void-packages.git
cd void-packages
./xbps-src binary-bootstrap
cd

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

sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4"/GRUB_CMDLINE_LINUX_DEFAULT="amdgpu.ppfeaturemask=0xffffffff amd_iommu=on iommu=pt loglevel=4"/' /etc/default/grub
sed -i 's/#GRUB_GFXMODE=1920x1080x32/GRUB_GFXMODE=3440x1440x32,1920x1080x32,auto/' /etc/default/grub
wget https://github.com/AdisonCavani/distro-grub-themes/raw/master/themes/void-linux.tar -P /home/joppe/Downloads
mkdir /home/joppe/Downloads/void-grub-theme
tar -xvf /home/joppe/Downloads/void-linux.tar -C /home/joppe/Downloads/void-grub-theme
mkdir /boot/grub/themes
cp -r /home/joppe/Downloads/void-grub-theme /boot/grub/themes/void
echo 'GRUB_THEME="/boot/grub/themes/void/theme.txt"' >> /etc/default/grub
update-grub

# git cloning configs from repo and symlinking them to directories

echo "git cloning configs from repo and copying them to directories..."

mkdir /home/joppe/repos
git clone git@github.com:juipeltje/configs.git /home/joppe/repos/configs
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

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip -P /home/joppe/Downloads/
mkdir /home/joppe/Downloads/Mononoki-Nerd-Font
unzip /home/joppe/Downloads/Mononoki.zip -d /home/joppe/Downloads/Mononoki-Nerd-Font/
cp -r /home/joppe/Downloads/Mononoki-Nerd-Font /usr/share/fonts/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Ubuntu.zip -P /home/joppe/Downloads/
mkdir /home/joppe/Downloads/Ubuntu-Nerd-Font 
unzip /home/joppe/Downloads/Ubuntu.zip -d /home/joppe/Downloads/Ubuntu-Nerd-Font/
cp -r /home/joppe/Downloads/Ubuntu-Nerd-Font /usr/share/fonts/

# installing themes

echo "installing themes..."

wget https://github.com/EliverLara/Nordic/releases/download/v2.2.0/Nordic.tar.xz -P /home/joppe/Downloads
tar -xvf /home/joppe/Downloads/Nordic.tar.xz -C /home/joppe/Downloads
cp -r /home/joppe/Downloads/Nordic /usr/share/themes
mkdir -p /home/joppe/kvantum-themes/Nordic
wget https://raw.githubusercontent.com/EliverLara/Nordic/master/kde/kvantum/Nordic/Nordic.kvconfig -P /home/joppe/kvantum-themes/Nordic/
wget https://raw.githubusercontent.com/EliverLara/Nordic/master/kde/kvantum/Nordic/Nordic.svg -P /home/joppe/kvantum-themes/Nordic/
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk /home/joppe/gruvbox-material-gtk
cp -r /home/joppe/gruvbox-material-gtk/themes/Gruvbox-Material-Dark /usr/share/themes/
cp -r /home/joppe/gruvbox-material-gtk/icons/Gruvbox-Material-Dark /usr/share/icons/
wget https://github.com/theglitchh/Gruvbox-Kvantum/releases/download/v1.1/gruvbox-kvantum-v1.1.zip -P /home/joppe/Downloads
unzip gruvbox-kvantum-v1.1.zip -d /home/joppe/kvantum-themes/
cp -r /home/joppe/repos/configs/config-files/usr/share/icons/capitaine-cursors-light /usr/share/icons/

wget https://github.com/eromatiya/lightdm-webkit2-theme-glorious/releases/download/v2.0.5/lightdm-webkit2-theme-glorious-2.0.5.tar.gz -P /home/joppe/Downloads/
mkdir /home/joppe/Downloads/lightdm-webkit2-theme-glorious
tar -xvf /home/joppe/Downloads/lightdm-webkit2-theme-glorious-2.0.5.tar.gz -C /home/joppe/Downloads/lightdm-webkit2-theme-glorious/
cp -r /home/joppe/Downloads/lightdm-webkit2-theme-glorious /usr/share/lightdm-webkit/themes/glorious

# setting up permissions for liquidctl

echo "setting up permissions for liquidctl..."

wget https://raw.githubusercontent.com/liquidctl/liquidctl/main/extra/linux/71-liquidctl.rules -P /etc/udev/rules.d/

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
ln -s /etc/sv/lightdm /var/service/
sv down lightdm

# fixing any ownership issues for the user's home folder

echo "fixing any ownership issues for the user's home folder..."

chown joppe /home/joppe

echo "Finished!! You can now reboot your machine."
