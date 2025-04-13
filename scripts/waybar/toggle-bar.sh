#!/usr/bin/env bash

# Script for wayland compositors to toggle hide/show Waybar

kill -SIGUSR1 $(pgrep waybar)
