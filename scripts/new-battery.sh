#!/usr/bin/env bash

# Script to make laptop hibernate when battery is too low
BATTERY="/sys/class/power_supply/BAT0"
CAPACITY=$(cat ${BATTERY}/capacity)
STATUS=$(cat ${BATTERY}/status)

if [ "${STATUS}" = Discharging -a "${CAPACITY}" -lt 5 ]; then
	notify-send 'Now hibernating...' "Battery level critical"
	sleep 5
	systemctl hibernate
elif [ "${STATUS}" = Discharging -a "${CAPACITY}" -lt 16 ]; then
	notify-send 'Battery low (${CAPACITY}%)' "please connect a charger"
fi
