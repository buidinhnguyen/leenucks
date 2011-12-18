#!/bin/sh

# net {{{1
net() {
	kib=$((2^10))
	net=eth0;

	old_rcv=$(cat /sys/class/net/${net}/statistics/rx_bytes)
	old_snd=$(cat /sys/class/net/${net}/statistics/tx_bytes)
	sleep 1
	new_rcv=$(cat /sys/class/net/${net}/statistics/rx_bytes)
	new_snd=$(cat /sys/class/net/${net}/statistics/tx_bytes)

	size_rcv=$((${new_rcv} - ${old_rcv}))
	size_snd=$((${new_snd} - ${old_snd}))

	rcv_speed=$(printf "%1.2f\n" $(echo "scale=2; (${new_rcv} - ${old_rcv}) / ${kib}" | bc)) 
	snd_speed=$(printf "%1.2f KiB/s\n" $(echo "scale=2; (${new_snd} - ${old_snd}) / ${kib}" | bc))

	echo -e "${rcv_speed}/${snd_speed} | "
}

# free diskspace in % {{{1
disk() {
	root=$(df -P | awk '/root/ { print $5 }')
	home=$(df -P | awk '/home/ { print $5 }')
	echo "${root}/${home} | "
}

# mpd playing {{{1
music() {
	mpc=$(mpc current) 
	mpcradio=$(mpc current | cut -c 53-120)
	mpcr=$(mpc current | grep -c Radio)
	if [ -z "${mpc}" ] ; then
		echo -e "[ MPD stopped | "
	elif [ "${mpcr}" -eq "1" ] ; then
		echo -n "[ ${mpcradio} | "
	else
		echo -n "[ ${mpc} | "
	fi
}

# uptime {{{1
up() {
	up=$(cat /proc/uptime)
	u=${up%%.*}

	m=$((u/60%60))
	h=$((u/3600%24))
	d=$((u/60/60/24))

	if [ "${d}" -gt "0" ] ; then
		echo -e "${d}d ${h}:${m} | "
	else
		echo -e "${h}:${m} | "
	fi
}

# date or mute {{{1
dm() {
	d=$(date +'%d/%m/%y %H:%M')
	dm=$(date +'%H:%M')
	vol=$(amixer -c 0 get Master | awk '/^  Mono:/ { print $3 }')
	if [ "${vol}" -eq "0" ]; then
		echo -e "--Mute-- ${dm} ]"
	else
		echo "${d} ]" 
	fi
}

# output {{{1
while true; do
#xsetroot -name "$(music)$(net)$(disk)$(up)$(dm)"
	xsetroot -name "[ $(dm)"
	sleep 1
done

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
