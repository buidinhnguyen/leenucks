#!/bin/sh
#
# lolilolicon's two-liner
#
###

# regex to grab uncommented mirrors
regex=$(sed '/^ *Server *= *\([^\$]*\)\$repo.*$/!d;s//\1/' /etc/pacman.d/mirrorlist | tr '\n' '|' | sed 's/|$//')

# fetch last update time and print
grep -E "$regex" <$(curl -s 'https://www.archlinux.de/?page=MirrorStatusReflector')

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
