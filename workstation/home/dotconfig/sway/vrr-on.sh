#!/usr/bin/env bash

# script for swayfx to enable vrr and turn on secondary monitor if it is off.
swaymsg output DP-1 adaptive_sync on
swaymsg output DP-2 enable
