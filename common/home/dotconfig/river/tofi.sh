#!/bin/sh

# River script for reading focused output with river-bedload/jq, and setting that output in tofi config
riverctl spawn "sed -i --follow-symlinks 's/^output.*/output = $(river-bedload -print outputs | jq -r '.[] | select(.focused) | .name')/' ~/.config/tofi/config"
riverctl spawn tofi-drun
