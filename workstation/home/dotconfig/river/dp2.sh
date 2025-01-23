#!/bin/sh

# River script for changing both active output and setting output to DP-2 in tofi config
riverctl focus-output DP-2
riverctl spawn "sed -i --follow-symlinks 's/^output.*/output = DP-2/' ~/.config/tofi/config"
