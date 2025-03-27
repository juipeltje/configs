#!/usr/bin/env bash

# waybar script for hyprland
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-hyprland",|' ~/.config/waybar/config
waybar &
