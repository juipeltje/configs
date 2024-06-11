#!/bin/bash

# waybar script to monitor AIO pump speed

sensors | awk '/Pump/ {print $2" "$3}'
