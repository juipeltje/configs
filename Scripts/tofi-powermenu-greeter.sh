#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot" | tofi --width 10% --height 15% | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                systemctl $op
esac
