#!/bin/bash
#
# simple volume script for conky
#
##

AM=`which amixer`
VOL=`$AM -c 0 get Master | awk '/^  Mono:/ { print $3 }'`

if [[ "$VOL" -ne "0" ]] ; then
	VOLNOW=`$AM -c 0 get Master | awk '/^  Mono:/ { print $3 "%" }'`
	echo "[Master: $VOLNOW]"
else
	echo "[Muted]"
fi
