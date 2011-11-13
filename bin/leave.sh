# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
#!/bin/bash
#
# a simple logout dialog
#
###
# kill_apps {{{1
kill_apps() {
	while read -r app; do
		wmctrl -i -c "$app"
	done < <(wmctrl -l | awk '{print $1}')
}
# choice_function {{{1
choice_by_dmenu() {
if [[ -f "${HOME}/.dmenurc" ]]; then
	. "${HOME}/.dmenurc"
else
	DMENU='dmenu -i'
fi

	choice="$(echo -e "a: Logout\nr: Reboot\ns: Shutdown" | $DMENU | cut -d ':' -f 1)"
}
# are we on X and is a choice being used? {{{1
[[ -z "$DISPLAY" ]] && exit 1

choice_by_dmenu

[[ -z "$choice" ]] && exit 1
# gracefully close all open apps {{{1
kill_apps
# execute the choice in background {{{1
case "$choice" in
	a) pkill X &     ;;
	r) sudo init 6 & ;;
	s) sudo init 0 & ;;
esac
