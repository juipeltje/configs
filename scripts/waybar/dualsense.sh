#!/usr/bin/env bash

# DualSense widget script for waybar.
BATTERY="/sys/class/power_supply/ps-controller-battery-7c:66:ef:11:df:5d"
CAPACITY=$(cat $BATTERY/capacity)
STATUS=$(cat $BATTERY/status)

if [ -d "$BATTERY" ]; then
  if [ "$STATUS" = "Discharging" || "$STATUS" = "Full" ]; then
    echo '{"text": "'"$CAPACITY%"'", "alt": "discharging"}'
  elif [ "$STATUS" = "Charging" ]; then
    echo '{"text": "'"$CAPACITY%"'", "alt": "charging"}'
  fi
else
  echo '{"alt": "disconnected"}'
fi
