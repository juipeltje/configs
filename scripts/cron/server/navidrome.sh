#!/usr/bin/env bash

# Script that starts Navidrome with the required flags, and sends logs to a file.

# redirect stderr and stdout to logfile.
user=navidrome
log=/home/${user}/log/navidrome/$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

until /home/${user}/.nix-profile/bin/navidrome -c /home/${user}/.config/navidrome/navidrome.toml; do
  echo "Navidrome crashed! if this keeps happening, please check your logs."
  sleep 1
done
