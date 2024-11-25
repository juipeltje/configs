#!/usr/bin/env bash

unset LD_PRELOAD
source /home/deck/.nix-profile/etc/profile.d/nix.sh
nix run --impure github:nix-community/nixGL#nixGL -- chiaki
