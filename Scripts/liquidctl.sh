#!/bin/bash
#liquidctl start script

/home/joppe/.local/bin/liquidctl initialize all 
sleep 2
/home/joppe/.local/bin/liquidctl --match kraken set pump speed 100
