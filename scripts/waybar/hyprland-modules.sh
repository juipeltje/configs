#!/usr/bin/env bash

# script that makes sure waybar config imports hyprland modules before waybar is started.

sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/hyprland-config\",|' ~/.config/waybar/common
