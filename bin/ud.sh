#!/bin/sh
# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
# check for permissions {{{1
if [ "$(id -ru)" -ne "0" ] ; then
	echo "Switch user to root"
	echo "Exiting"
	exit 1
fi

# what apps had a .so-update {{{1
if [ -e "/usr/sbin/lsof" ] ; then
	foo=$(lsof | grep 'DEL.*lib' | cut -f 1 -d ' ' | sort -u)
	if [ -n "$foo" ] ; then
			echo -e "These apps need a restart"
			echo "$foo"
	fi
fi
