#!/usr/bin/env bash

# crontab script to hibernate laptop when battery is low.

# redirect stderr and stdout to logfile.
log=/var/log/battery-crit-$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

# script that checks battery level and hibernates when battery is low.
BATTERY="/sys/class/power_supply/BAT0"
CAPACITY=$(cat $BATTERY/capacity)
STATUS=$(cat $BATTERY/status)

if [ "$STATUS" = Discharging -a "$CAPACITY" -lt 5 ]; then
	sleep 5
	loginctl hibernate
fi
