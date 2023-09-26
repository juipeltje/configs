#!/bin/bash
# lock screen before suspend/hibernate

username=joppe
userhome=/home/$username
export XAUTHORITY="$userhome/.Xauthority"
export DISPLAY=":0.0"
case "${1}" in
  pre)
    su $username -c "/home/joppe/repos/configs/Scripts/screenlocker-workstation.sh" &
    sleep 1;
    ;;
esac
