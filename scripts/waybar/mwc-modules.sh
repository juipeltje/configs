#!/usr/bin/env bash

# script that makes sure waybar config imports mwc modules before waybar is started.

sed -i --follow-symlinks 's|\"include\".*|\"include\": \"~/.config/waybar/mwc-config\",|' ~/.config/waybar/common
