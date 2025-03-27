#!/usr/bin/env bash

# waybar script for Niri
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-niri",|' ~/.config/waybar/config
waybar &
