#!/usr/bin/env bash

# script for swayfx to disable secondary monitor
swaymsg output DP-1 adaptive_sync on
swaymsg output DP-2 disable
