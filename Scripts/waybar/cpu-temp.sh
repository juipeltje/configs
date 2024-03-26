#!/usr/bin/env bash

# waybar script for cpu temperature widget

sensors k10temp-pci-00c3 | grep Tctl | awk '{print $2}' | sed 's/+/ /'
