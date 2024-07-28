#!/usr/bin/env bash

# waybar script to monitor gpu temp

sensors | awk '/edge/ {print $2}' | sed 's/+/ /'
