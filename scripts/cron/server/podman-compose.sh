#!/usr/bin/env bash

# Script that starts podman-compose with the required flags, and retries if it fails.

# redirect stderr and stdout to logfile.
user=joppe
log=/home/${user}/log/podman-compose/$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

until podman-compose -f /home/${user}/.config/containers/compose.yml up -d; do
  echo "podman-compose failed! if this keeps happening, please check your logs."
  sleep 1
done
