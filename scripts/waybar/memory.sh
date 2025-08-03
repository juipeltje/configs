#!/usr/bin/env bash

# waybar script to monitor memory usage in GB

free --giga --human | awk '/Mem:/ {print $3"/"$7}' | sed 's/G//g' | sed 's/$/ GB/'
