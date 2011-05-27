#!/bin/bash

TMX="$(pgrep tmux)"

if [[ -z "${TMX}" ]] ; then
	tmux start
else
	urxvtc -e tmux attach-session
fi
