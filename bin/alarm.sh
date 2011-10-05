#!/bin/sh

amixer -q -c0 set Master 100 unmute

#mpc -q pause

/usr/bin/xterm -display :0 -bg black -fg white \
-e /usr/bin/mplayer -loop 0 -playlist ~/.playlist

amixer -q -c0 set Master 80 unmute

# vim:fenc=utf-8:nu:ai:si:et:ts=2:sw=2:
