#!/bin/sh

# read the pid of any still-running instance
IFS=$(printf '\n' read -r pid < <$(pgrep offlineimap))

# need be, kill it
[ -n "$pid" ] && kill -9 $pid

# (re)sync
offlineimap -o -u Noninteractive.Quiet >/dev/null 2>&1 &

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
