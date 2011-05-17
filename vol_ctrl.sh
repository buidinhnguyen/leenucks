#!/bin/bash

case $1 in
  up)
    amixer -q -c 0 set Master 5+
    notify-send -t 0 "`amixer get Master | awk '/^  Mono:/ { print $4 }'`"
    ;;
  down)
    amixer -q -c 0 set Master 5-
    notify-send -t 0 "`amixer get Master | awk '/^  Mono:/ { print $4 }'`"
    ;;
  mute)
    volcheck=(`amixer -c 0 get Master | awk "/^  Mono:/"`)
    if [[ "${volcheck[2]}" -ne "0" ]] ; then
      amixer -q -c 0 set Master 0
    else
      amixer -q -c 0 set Master 80
    fi
    ;;
  *)
    echo "Usage: `basename $0` (up|down|mute)"
    ;;
esac
