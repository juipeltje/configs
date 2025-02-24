#!/bin/bash
# lock screen before suspend/hibernate

username=joppe
userhome=/home/$username
export WAYLAND_DISPLAY="wayland-1"
export DISPLAY=":0"
export XDG_RUNTIME_DIR="/run/user/1000"
case $1 in
  pre)
    su $username -c "gtklock -d" &
    sleep 1;
    ;;
esac
