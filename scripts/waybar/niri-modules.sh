#!/usr/bin/env bash

# script that makes sure waybar config imports niri modules before waybar is started.

sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/niri-config\",|' ~/.config/waybar/common
