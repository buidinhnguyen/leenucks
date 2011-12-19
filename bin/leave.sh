#!/bin/sh
# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
#
# a simple logout dialog
#
###
choice_by_dmenu() {
if [ -f "${HOME}/.dmenurc" ]; then
	. "${HOME}/.dmenurc"
else
	DMENU='dmenu -i'
fi

	choice="$(echo -e "a: Logout\nr: Reboot\ns: Shutdown" | $DMENU | cut -d ':' -f 1)"
}

# are we on X and is a choice being used?
[ -z "$DISPLAY" ] && exit 1

choice_by_dmenu

[ -z "$choice" ] && exit 1

# execute the choice in background 
case "$choice" in
	a) pkill X &     ;;
	r) sudo init 6 & ;;
	s) sudo init 0 & ;;
esac
