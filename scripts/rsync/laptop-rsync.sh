#!/usr/bin/env bash

# rsync script for backing up laptop files

# user variable
user=joppe

# rsync command
rsync -avR --delete-before \
/home/$user/.password-store \
/home/$user/.ssh \
/home/$user/Documents \
/home/$user/Downloads \
/home/$user/Music \
/home/$user/Pictures \
/home/$user/Videos \
/home/$user/private-key.asc \
/run/media/$user/Backup-Drive/Laptop-Backup
