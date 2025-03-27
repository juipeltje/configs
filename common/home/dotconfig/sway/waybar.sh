#!/usr/bin/env bash

# waybar script for swayfx
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-sway",|' ~/.config/waybar/config
waybar &
