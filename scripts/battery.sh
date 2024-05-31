#!/bin/bash
#Script to make laptop hibernate when battery is too low

acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
	read -r status capacity

	if [ "$status" = Discharging -a "$capacity" -lt 5 ]; then

                notify-send 'Now hibernating...' "Battery level critical"
                sleep 5
                loginctl hibernate 

        fi
}
