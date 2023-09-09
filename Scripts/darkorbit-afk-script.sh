 
#!/bin/bash

while true; do
  xdotool key 2
  sleep $((RANDOM % 90))
  xdotool key 1
  sleep $((RANDOM % 90))
done
