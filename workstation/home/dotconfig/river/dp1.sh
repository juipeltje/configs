#!/bin/sh

# River script for changing both active output and setting output to DP-1 in tofi config
riverctl focus-output DP-1
riverctl spawn "sed -i --follow-symlinks 's/^output.*/output = DP-1/' ~/.config/tofi/config"
