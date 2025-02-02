#!/usr/bin/env bash

# wrapper script for updating my void systems

set -e

# Variables
user=joppe

# Update xbps package manager
xbps-install -u xbps

# Update packages with xbps
xbps-install -Su

# Replacing desktop session shortcuts in case they are overwritten by update
cp -f /home/${user}/repos/configs/common/usr/share/xsessions/i3.desktop /usr/share/xsessions/
cp -f /home/${user}/repos/configs/common/usr/share/xsessions/qtile.desktop /usr/share/xsessions/
cp -f /home/${user}/repos/configs/common/usr/share/wayland-sessions/river.desktop /usr/share/wayland-sessions/
cp -f /home/${user}/repos/configs/common/usr/share/wayland-sessions/sway.desktop /usr/share/wayland-sessions/

# Check for services that need to be restarted with xcheckrestart
sudo -u ${user} xcheckrestart

# Update Flatpaks
sudo -u ${user} flatpak update
