#!/usr/bin/env bash

# rsync script for backing up workstation files

# user variable
user=joppe

# rsync command
rsync -avR --delete-before \
/6TB-HDD/Monero \
/6TB-HDD/Pictures \
/6TB-HDD/PS-Vita \
/6TB-HDD/ROMS \
/6TB-HDD/systemd-backup \
/6TB-HDD/Videos \
/home/${user}/.mozilla/firefox/j5fcylj2.default-default \
/home/${user}/.password-store \
/home/${user}/.ssh \
/home/${user}/2FAQR \
/home/${user}/AppImages/icons \
/home/${user}/CPUWorker1 \
/home/${user}/Documents \
/home/${user}/Downloads \
/home/${user}/GPUWorker1 \
/home/${user}/Music \
/home/${user}/Pictures \
/home/${user}/Videos \
/home/${user}/private-key.asc \
/run/media/${user}/Backup-Drive/Workstation-Backup
