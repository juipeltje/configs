#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot" | wofi -c /etc/greetd/wofi-config -s /etc/greetd/wofi-style.css --width 10% --height 15% | awk '{print tolower($2)}' )

case $op in 
        poweroff)
                ;&
        reboot)
                systemctl $op
esac
