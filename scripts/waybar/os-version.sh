#!/usr/bin/env bash

# waybar script for displaying NixOS version

cat /etc/os-release | awk -F'"' '/VERSION_ID/ {print $2}'
