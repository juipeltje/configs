#!/bin/sh

# crontab script for symlinking graphics drivers to /run directory for nix packages.
DRIVERS="/nix/var/nix/profiles/per-user/joppe/profile/drivers"

if [ -d "$DRIVERS" ]; then
  ln -sf /nix/var/nix/profiles/per-user/joppe/profile/drivers/opengl-driver /run/opengl-driver
  ln -sf /nix/var/nix/profiles/per-user/joppe/profile/drivers/opengl-driver-32 /run/opengl-driver-32
fi

