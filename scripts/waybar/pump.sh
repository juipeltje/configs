#!/bin/bash

# waybar script to monitor AIO pump speed

sensors | grep Pump | awk '{print $2" "$3}'
