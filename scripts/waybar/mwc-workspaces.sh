#!/usr/bin/env bash

# active-workspace event has two args separated by the \x1E separator sequence
#   - workspace index
#   - workspace output
#
mwc-ipc subscribe | while read -r line; do
  # if the line starts with active-workspace
  if [[ "$line" == active-workspace* ]]; then
    # we extract the arguments and take the second one - index and third one - output
    number=$(echo "$line" | cut -d$(printf '\x1E') -f2)
    #output=$(echo "$line" | cut -d$(printf '\x1E') -f3)
    echo "$number"
  fi
done
