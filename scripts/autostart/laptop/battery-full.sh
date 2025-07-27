#!/usr/bin/env bash

# script to notify user when battery is fully charged.

# redirect stderr and stdout to logfile.
user=joppe
log=/home/${user}/log/battery-full-$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

# script that checks battery level and notifies user when fully charged.
BATTERY="/sys/class/power_supply/BAT0"
STATUS=NotFull

while true; do
  sleep 120

  REAL_STATUS=$(cat $BATTERY/status)

  if [ "$REAL_STATUS" = "Full" -a "$REAL_STATUS" != "$STATUS" ]; then
  	STATUS=$REAL_STATUS
	notify-send "󰂅 Battery fully charged!"
  elif [ "$REAL_STATUS" != "$STATUS" ]; then
	STATUS=NotFull
  fi
done
