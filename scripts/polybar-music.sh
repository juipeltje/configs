#!/bin/bash

# script for polybar to improve music status display

if [ playerctl metadata --format "Now playing: {{ title }} - {{ artist }}" | grep "No players found" ]; then
   echo "n/a"  
fi 
