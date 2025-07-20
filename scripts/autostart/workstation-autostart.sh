#!/usr/bin/env bash

# workstation autostart script to be executed by window managers.
liquidctl initialize all
sleep 2
liquidctl --match kraken set pump speed 100
yoda --match commander control sync with "(40,40),(50,45),(55,50),(60,60),(65,70),(70,80),(80,90),(85,100)" on k10temp.tctl &
openrgb -p purple.orp
HSA_OVERRIDE_GFX_VERSION="10.3.0" ollama serve &
