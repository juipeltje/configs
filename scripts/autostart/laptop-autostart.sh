#!/usr/bin/env bash

# laptop autostart script to be executed by window managers.
ollama serve &
~/repos/configs/scripts/autostart/laptop/battery-full.sh &
~/repos/configs/scripts/autostart/laptop/battery-low.sh &
~/repos/configs/scripts/autostart/laptop/charger.sh &
