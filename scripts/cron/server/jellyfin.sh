#!/usr/bin/env bash

# Script that starts Jellyfin with the required flags, and sends logs to a file.

# redirect stderr and stdout to logfile.
user=joppe
log=/home/${user}/log/jellyfin/$(date +%d-%m-%Y).log
JELLYFINDIR="/home/joppe/.jellyfin"
exec 1>>${log} 2>&1

until jellyfin -d $JELLYFINDIR/data -C $JELLYFINDIR/cache -c $JELLYFINDIR/config -l $JELLYFINDIR/log; do
  echo "Jellyfin crashed! if this keeps happening, please check your logs."
  sleep 1
done
