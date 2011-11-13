#!/bin/bash

TMX="$(pgrep tmux)"

if [[ -z "${TMX}" ]] ; then
	tmux start
else
	urxvtc -e tmux attach-session
fi

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
