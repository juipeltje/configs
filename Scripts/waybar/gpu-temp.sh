#!/bin/bash

# waybar script to monitor gpu temp

sensors amdgpu-pci-0b00 | grep edge | awk '{print $2}' | sed 's/+/ /'
