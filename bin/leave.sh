#!/bin/bash
#
# a simple logout dialog
#
###

kill_apps() {
  while read -r app; do
    wmctrl -i -c "$app"
  done < <(wmctrl -l | awk '{print $1}')
}

choice_by_dmenu() {
if [[ -f "${HOME}/.dmenurc" ]]; then
  . "${HOME}/.dmenurc"
else
  DMENU='dmenu -i'
fi
 
  choice="$(echo -e "a: Logout\nr: Reboot\ns: Shutdown" | $DMENU | cut -d ':' -f 1)"
}

[[ -z "$DISPLAY" ]] && exit 1

choice_by_dmenu

[[ -z "$choice" ]] && exit 1

# gracefully close all open apps
kill_apps

# execute the choice in background
case "$choice" in
  a) pkill X &     ;;
  r) sudo init 6 & ;;
  s) sudo init 0 & ;;
esac

# vim:fenc=utf-8:nu:ai:si:et:ts=2:sw=2:
