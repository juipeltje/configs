#!/usr/bin/env bash

# waybar script to monitor memory usage in MB

free --mega | grep Mem | awk '{print$3" "$2}' | sed 's/ /\//' | sed 's/$/ MB/'
