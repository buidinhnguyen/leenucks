#!/bin/sh
# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
#
# alarm script working with mpd/mpc or mplayer/xterm
#
# ~/.playlist: {{{1
#   touch ~/.playlist
#   find $MUSIC-DIRECTORY -iname '*.mp3' -o -iname '*.ogg' |\
#   grep "$DESIRED_BAND" or "$DESIRED_SONG" >> ~/.playlist
#
# Dependencies: {{{1
#  - amixer
#  - bc
#  - mpc
#  - mpd
#  - mplayer
#  - xterm
#
# variables {{{1
MPC=$(which mpc)
AMIXER=$(which amixer)
BC="$(which bc) -l"
MPDRUNFILE="$XDG_CONFIG_HOME/mpd/pid"
VOLUME="$1"

#backup_wakeup function {{{1
backup_wakeup() {
	$(which xterm) -display :0.0 -e $(which mplayer) -loop 0 -playlist ~/.playlist &
}

# starter_help {{{1
if [ "$#" -ne "3" ] ; then
	echo "usage: $(basename $0) <start volume> <end volume> <length in secs>" ;
	exit 1 ;
fi

# check if mpd is running, and with some files to play {{{1
if [ -e "$MPDRUNFILE" ] ; then
	$MPC -q stop
	sleep 1
	$MPC -q play
fi

if [ "$(mpc playlist | wc -l)" -eq "0" ] ; then
	backup_wakeup ;
else
	$MPC -q stop
	sleep 1
	$MPC -q play
fi

# volume fade {{{1
if [ "$1" -lt "$2" ] ; then
	while [ "$VOLUME" -le "$2" ] ; do
		$AMIXER -q -c 0 set Master "$VOLUME" unmute > /dev/null ;
		VOLUME="$(($VOLUME + 1))" ;
		sleep $(echo "$3/($2-$1)" | $BC) ;
	done
else
	while [ "$VOLUME" -ge "$2" ] ; do
		$AMIXER -q -c 0 set Master "$VOLUME" unmute > /dev/null ;
		VOLUME=$(($VOLUME - 1)) ;
		sleep $(echo "$3/($1-$2)" | $BC) ;
	done
fi
