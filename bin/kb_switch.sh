# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
#!/bin/bash
#
# keymap switcher
#
###
# check for ~/.dmenurc {{{1
if [[ -f "${HOME}/.dmenurc" ]]; then
	. "${HOME}/.dmenurc"
else
	DMENU='dmenu -i'
fi
# choice? {{{1
choice="$(echo -e "a: GB Colemak\nr:US\ns:DE" | $DMENU | cut -d ':' -f 1)"
# keymap switch {{{1
case "${choice}" in 
	a) setxkbmap gb colemak && xset r 66 ;; 
	r) setxkbmap us && xset r 66         ;;
	s) setxkbmap de && xset r 66         ;;
esac
