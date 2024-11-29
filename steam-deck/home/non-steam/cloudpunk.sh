#!/usr/bin/env bash

unset LD_PRELOAD
source /home/deck/.nix-profile/etc/profile.d/nix.sh
nixGLIntel nixVulkanIntel heroic --no-gui --no-sandbox "heroic://launch/gog/2048907635"
