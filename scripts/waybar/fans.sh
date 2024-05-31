#!/bin/bash

# waybar script to monitor case fan speed

sensors | grep fan2 | awk '{print $3" "$4}'
