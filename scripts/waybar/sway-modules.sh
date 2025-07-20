#!/usr/bin/env bash

# script that makes sure waybar config imports sway modules before waybar is started.

sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/sway-config\",|' ~/.config/waybar/common
