#!/bin/bash

# rsync script for backing up workstation files

rsync -avR \
/home/joppe/.mozilla/firefox/j5fcylj2.default-default \
/home/joppe/.password-store \
/home/joppe/.ssh \
/home/joppe/2FAQR \
/home/joppe/6TB-HDD \
/home/joppe/AppImages/icons \
/home/joppe/CPUWorker1 \
/home/joppe/Documents \
/home/joppe/Downloads \
/home/joppe/GPUWorker1 \
/home/joppe/Music \
/home/joppe/Pictures \
/home/joppe/Videos \
/run/media/joppe/Backup-Drive/Workstation-Backup
