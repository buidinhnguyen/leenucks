#!/bin/sh
#
# Requirements:
#   amixer
#   xcowsay
#

case $1 in
	up)
		amixer -q -c 0 set Master 5+
		xcowsay -t 2 "$(amixer get Master | awk '/^  Mono:/ { print $4 }')"
	;;
	down)
		amixer -q -c 0 set Master 5-
		xcowsay -t 2 "$(amixer get Master | awk '/^  Mono:/ { print $4 }')"
	;;
	mute)
		volcheck=($(amixer -c 0 get Master | awk "/^  Mono:/"))
		if [ "${volcheck[0|2|@]}" -ne "0" ] ; then
			amixer -q -c 0 set Master 0
		else
			amixer -q -c 0 set Master 80
		fi
	;;
	*)
		echo "Usage: $(basename $0) (up|down|mute)"
	;;
esac

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
