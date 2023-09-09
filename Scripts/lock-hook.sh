#!/bin/bash
# lock screen before suspend/hibernate

username=joppe
userhome=/home/$username
export XAUTHORITY="$userhome/.Xauthority"
export DISPLAY=":0.0"
case "${1}" in
  pre)
    su $username -c "/home/joppe/Scripts/screenlocker.sh" &
    sleep 1;
    ;;
esac
