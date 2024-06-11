#!/bin/bash

# waybar script to monitor case fan speed

sensors | awk '/fan2/ {print $3" "$4}'
