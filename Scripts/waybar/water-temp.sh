#!/bin/bash

# waybar script to monitor AIO water temperature

sensors | grep Coolant | awk '{print $2}' | sed 's/+/ /'
