#!/usr/bin/env bash

# Dualsense icon widget script for qtile bar.
BATTERY="/sys/class/power_supply/ps-controller-battery-7c:66:ef:11:df:5d"
CAPACITY=$(cat $BATTERY/capacity)
STATUS=$(cat $BATTERY/status)

if [ -d "$BATTERY" ]; then
  if [ "$STATUS" = "Discharging" -o "$STATUS" = "Full" ]; then
    echo " 󰖺"
  elif [ "$STATUS" = "Charging" ]; then
    echo " 󰨢"
  fi
else
  echo " 󰖻"
fi
