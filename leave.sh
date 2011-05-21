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

choice_by_zenity() {
	choice=$(zenity --title="Logout $HOSTNAME" \
 	                --text="Logout $HOSTNAME:" \
	                --list --radiolist \
	                --hide-column=3 --print-column=3 \
	                --column='' --column='' --column='' \
	                TRUE Logout 0 FALSE Reboot 1 FALSE Shutdown 2)
}

choice_by_dmenu() {
	if [[ -f "$HOME/.dmenurc" ]]; then
		. "$HOME/.dmenurc"
	else
		DMENU='dmenu -i'
	fi
  
	choice="$(echo -e "a: Logout\nr: Reboot\ns: Shutdown" | $DMENU | cut -d ':' -f 1)"
}

[[ -z "$DISPLAY" ]] && exit 1

#choice_by_zenity
choice_by_dmenu

[[ -z "$choice" ]] && exit 1

# gracefully close all open apps
kill_apps

# execute the choice in background
case "$choice" in
	a) pkill X &              ;;
	r) sudo shutdown -r now & ;;
	s) sudo shutdown -h now & ;;
esac
