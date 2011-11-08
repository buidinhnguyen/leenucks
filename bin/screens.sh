#!/bin/bash
#
# screens via dmenu

screens="a: torrent+mutt\nr:irssi+newsbeuter"

if [[ -f "$HOME/.dmenurc" ]]; then
	. "$HOME/.dmenurc"
else
	DMENU='dmenu -i'
fi

choice="$(echo -e ${screens} | $DMENU | cut -d ':' -f 1)"

case "${choice}" in
	a)
		# torrent+mutt
		if [[ -z "$(screen -ls | grep torrent)" ]] ; then      # does it exist?
			urxvtc -e screen -S torrent -c ${HOME}/.screen/tr    # no: create it
		else
			urxvtc -e screen -r torrent                          # yes: switch to it
		fi
		;;
	r)
	# irssi+newsbeuter screen
	if [[ -z "$(screen -ls | grep irc)" ]] ; then          # does it exist?
		urxvtc -e screen -S irc -c ${HOME}/.screen/irc       # no: create it
	else
		urxvtc -e screen -r irc                              # yes: switch to it
	fi
	;;
esac

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:
