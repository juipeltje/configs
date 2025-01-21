#!/usr/bin/env bash

# crontab script to start liquidctl and yoda script.

# redirect stderr and stdout to logfile.
log=/var/log/liquidctl-$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

# start liquidctl and yoda script.
liquidctl initialize all
sleep 2
liquidctl --match kraken set pump speed 100
/home/joppe/repos/configs/scripts/yoda.py --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl
