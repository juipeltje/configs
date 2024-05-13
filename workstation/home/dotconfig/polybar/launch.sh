#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Launch bars
polybar bar1 &
polybar bar2 &
