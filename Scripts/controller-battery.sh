#!/bin/bash

# script for polybar to check controller battery percentage
 
if [ -f /sys/class/power_supply/ps-controller-battery-7c:66:ef:11:df:5d/capacity ]; then
   cat /sys/class/power_supply/ps-controller-battery-7c:66:ef:11:df:5d/capacity | sed 's/$/%/' 
else
   echo "n/a"
fi
