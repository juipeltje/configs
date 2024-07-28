#!/usr/bin/env bash

# waybar script for cpu temperature widget

sensors k10temp-pci-00c3 | awk '/Tctl/ {print $2}' | sed 's/+/ /'
