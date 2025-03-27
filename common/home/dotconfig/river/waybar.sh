#!/usr/bin/env bash

# waybar script for River
sed -i --follow-symlinks 's|"include".*|"include": "~/.config/waybar/modules-river",|' ~/.config/waybar/config
waybar &
