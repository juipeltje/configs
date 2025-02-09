#!/usr/bin/env bash

# wrapper script for updating my void systems

set -e

# Variables
user=joppe
color_reset="\033[0m"
green="\033[0;32m"

# Update xbps package manager
echo -e "${green}Starting Void-updater script... (current user is '${user}')${color_reset}"
echo -e "${green}Checking if the xbps package need to be updated...${color_reset}"
xbps-install -u xbps

# Update packages with xbps
echo -e "${green}Checking for updates with xbps...${color_reset}"
xbps-install -Su

# Replacing desktop session shortcuts in case they are overwritten by update
echo -e "${green}Replacing desktop session shortcuts in case they are overwritten by update...${color_reset}"
cp -f /home/${user}/repos/configs/common/usr/share/xsessions/i3.desktop /usr/share/xsessions/
cp -f /home/${user}/repos/configs/common/usr/share/xsessions/qtile.desktop /usr/share/xsessions/
cp -f /home/${user}/repos/configs/common/usr/share/wayland-sessions/river.desktop /usr/share/wayland-sessions/
cp -f /home/${user}/repos/configs/common/usr/share/wayland-sessions/sway.desktop /usr/share/wayland-sessions/
cp -f /home/${user}/repos/configs/common/usr/share/wayland-sessions/niri.desktop /usr/share/wayland-sessions/

# Check for services that need to be restarted with xcheckrestart
echo -e "${green}Checking for services that need to be restarted with xcheckrestart...${color_reset}"
echo -e "${green}The following services need to be restarted:${color_reset}"
sudo -u ${user} xcheckrestart

# Update Flatpaks
echo -e "${green}Checking for flatpak updates...${color_reset}"
sudo -u ${user} flatpak update

# Finished
echo -e "${green}Finished! system is fully updated.${color_reset}"
