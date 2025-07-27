#!/usr/bin/env bash

# script to notify user when battery is charging/discharging.

# redirect stderr and stdout to logfile.
user=joppe
log=/home/${user}/log/charger-$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

# script that checks whether battery is charging/discharging.
BATTERY="/sys/class/power_supply/BAT0"
STATUS=$(cat $BATTERY/status)

while true; do
  REAL_STATUS=$(cat $BATTERY/status)

  if [ "$REAL_STATUS" != "$STATUS" ]; then
  	STATUS=$REAL_STATUS
	notify-send "󰚥 Battery $(cat /sys/class/power_supply/BAT0/status)..."
  fi
done
