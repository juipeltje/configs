#!/bin/bash

# waybar script to monitor AIO water temperature

sensors | awk '/Coolant/ {print $2}' | sed 's/+/ /'
