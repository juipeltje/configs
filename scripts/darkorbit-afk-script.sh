#!/usr/bin/env bash

# macro script to stay afk in darkorbit
 
while true; do
  xdotool key $((1 + RANDOM % 7)) 
  sleep $((2 + RANDOM % 90))
done
