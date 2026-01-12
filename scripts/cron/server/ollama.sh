#!/usr/bin/env bash

# Script that starts Ollama with the required flags, and sends logs to a file.

# redirect stderr and stdout to logfile.
user=gpu
log=/home/${user}/log/ollama/$(date +%d-%m-%Y).log
exec 1>>${log} 2>&1

until HSA_OVERRIDE_GFX_VERSION="9.0.0" OLLAMA_HOST=0.0.0.0 OLLAMA_MODELS=/12TB-HDD/ollama /home/${user}/.nix-profile/bin/ollama serve; do
  echo "Ollama crashed! if this keeps happening, please check your logs."
  sleep 5
done
