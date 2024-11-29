#!/usr/bin/env bash

unset LD_PRELOAD
source /home/deck/.nix-profile/etc/profile.d/nix.sh
WINEARCH="win64" WINEFSYNC="1" WINEPREFIX="/home/deck/.local/share/anime-game-launcher/prefix" WINE_FULLSCREEN_FSR="0" bash -c "'/home/deck/.local/share/anime-game-launcher/runners/lutris-GE-Proton8-26-x86_64/bin/wine64'  /home/deck/.local/share/anime-game-launcher/Genshin\ Impact/GenshinImpact.exe  "
