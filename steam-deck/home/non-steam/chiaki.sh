#!/usr/bin/env bash

unset LD_PRELOAD
source /home/deck/.nix-profile/etc/profile.d/nix.sh
nix run github:nix-community/nixGL#nixGLIntel -- chiaki
