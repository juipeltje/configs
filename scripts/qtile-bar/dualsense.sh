#!/usr/bin/env bash

# Dualsense icon widget script for qtile bar.
BATTERY="/sys/class/power_supply/ps-controller-battery-7c:66:ef:11:df:5d"
CAPACITY=$(cat $BATTERY/capacity)
STATUS=$(cat $BATTERY/status)

if [ -d "$BATTERY" ]; then
  if [ "$STATUS" = "Discharging" -o "$STATUS" = "Charging" ]; then
    echo "$CAPACITY%"
  elif [ "$STATUS" = "Full" ]; then
    echo "Full!"
  fi
else
  echo ""
fi
