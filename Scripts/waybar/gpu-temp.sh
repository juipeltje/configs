#!/bin/bash

# waybar script to monitor gpu temp

sensors | grep edge | awk '{print $2}' | sed 's/+/ /'
