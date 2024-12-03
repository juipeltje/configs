#!/usr/bin/env bash

unset LD_PRELOAD
source /home/deck/.nix-profile/etc/profile.d/nix.sh
nixGLIntel nixVulkanIntel bottles-cli run -b EA -e /home/deck/.local/share/bottles/bottles/EA/drive_c/Program\ Files/EA\ Games/STAR\ WARS\ Battlefront\ II/starwarsbattlefrontii.exe
