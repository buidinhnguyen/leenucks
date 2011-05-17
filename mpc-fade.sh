#!/bin/bash
#
# alarm script working with mpd and mpc or mplayer and xterm
#
# ~/.playlist:
#   touch ~/.playlist
#   find ${MUSIC-DIRECTORY} -iname '*.mp3' -o -iname '*.ogg' | grep "${DESIRED_BAND}" or "${DESIRED_SONG}" >> ~/.playlist
#
# Dependencies:
#  - amixer
#  - bc
#  - mpc
#  - mpd
#  - mplayer
#  - xterm
#

MPC=`which mpc`
AMIXER=`which amixer`
BC="`which bc` -l"
MPDRUNFILE="/var/run/mpd"

backup_wakeup() {
   ${AMIXER} -q -c 0 set Master 100 unmute

   $(which xterm) -display :0.0 -bg black -fg white \
   -e $(which mplayer) -loop 0 -playlist ~/.playlist

   ${AMIXER} -q -c 0 set Master 70 unmute
}

if [[ "$#" -ne "3" ]] ; then
   echo "usage: mpc-fade <start volume> <end volume> <length in secs>" ;
   exit 1 ;
fi

${AMIXER} -q -c 0 set Master 100 unmute

# check if mpd is running, and with some files to play
if [[ ! -e "${MPDRUNFILE}" ]] ; then
   backup_wakeup ;
fi

if [ `mpc playlist | wc -l` -eq "0" ] ; then
   backup_wakeup ;
fi

VOLUME=$1
${MPC} stop > /dev/null
sleep 1
${MPC} play > /dev/null

if [[ "$1" -lt "$2" ]] ; then
   while [[ "${VOLUME}" -le "$2" ]] ; do
           ${MPC} volume "${VOLUME}" > /dev/null ;
           VOLUME="$((${VOLUME} + 1))" ;
      sleep `echo "$3/($2-$1)" | $BC` ;
   done ;
else
   while [[ "${VOLUME}" -ge "$2" ]] ; do
           $MPC volume "${VOLUME}" > /dev/null ;
           VOLUME=$((${VOLUME} - 1)) ;
           sleep `echo "$3/($1-$2)" | $BC` ;
    done ;
fi

# eof
