#!/usr/bin/env bash

# script that makes sure waybar config imports river modules before waybar is started.

sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/river-config\",|' ~/.config/waybar/common
