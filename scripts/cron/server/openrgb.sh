#!/usr/bin/env bash

# Script that starts OpenRGB, and sends logs to a file.

# redirect stderr and stdout to logfile.
user=joppe
log=/home/${user}/log/openrgb/$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

until openrgb -p /home/${user}/.config/OpenRGB/off.orp; do
  echo "OpenRGB crashed! if this keeps happening, please check your logs."
  sleep 1
done
