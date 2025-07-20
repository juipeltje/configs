#!/usr/bin/env bash

# script that makes sure waybar config imports dwl modules before waybar is started.

sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/dwl-config\",|' ~/.config/waybar/common
