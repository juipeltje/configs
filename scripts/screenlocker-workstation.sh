#!/bin/bash

BLANK='#00000000'
CLEAR='#8fbcbb'
DEFAULT='2e3440'
TEXT='#d8dee9'
WRONG='#bf616a'
VERIFYING='#2e3440'

i3lock \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$WRONG   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--greeter-color=$TEXT	\
--layout-color=$TEXT         \
--keyhl-color=$CLEAR         \
--bshl-color=$WRONG          \
\
--screen 1                   \
--clock                      \
--indicator                  \
--greeter-text "Welcome back Joppe!"	\
--greeter-pos="ix-0:iy+150"	\
--time-str="%H:%M"        \
--date-str="%d-%m-%Y"       \
--time-font "Ubuntu Nerd Font Medium"	\
--date-font "Ubuntu Nerd Font Medium"	\
--wrong-font "Ubuntu Nerd Font Medium"	\
--verif-font "Ubuntu Nerd Font Medium"	\
--layout-font "Ubuntu Nerd Font Medium"	\
--greeter-font "Ubuntu Nerd Font Medium"	\
--image /home/joppe/Pictures/Wallpapers/japan/tokyo1.png  \
