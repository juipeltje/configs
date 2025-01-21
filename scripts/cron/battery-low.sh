#!/usr/bin/env bash

# crontab script to notify user when battery is low.

# redirect stderr and stdout to logfile.
user=joppe
log=/home/${user}/log/battery-low-$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

# script that checks battery level and notifies user when low.
BATTERY="/sys/class/power_supply/BAT0"
CAPACITY=$(cat $BATTERY/capacity)
STATUS=$(cat $BATTERY/status)

while true; do
  if [ "$STATUS" = Discharging -a "$CAPACITY" -lt 5 ]; then
	notify-send -u critical "󱃍 Battery critical: $(cat /sys/class/power_supply/BAT0/capacity)%" "hibernating soon..."
	sleep 120
  elif [ "$STATUS" = Discharging -a "$CAPACITY" -lt 16 ]; then
	notify-send -u critical "󱃍 Battery low: $(cat /sys/class/power_supply/BAT0/capacity)%" "please connect a charger"
	sleep 120
  fi
done
