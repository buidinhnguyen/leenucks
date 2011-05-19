#!/bin/bash

function netstatus {
kib=$[2**10]
mib=$[2**20]

if [[ "ping -qc1 heise.de 2> /dev/null" ]] ; then
  if [[ $(ifconfig|grep -c wlan0) -ne "0" ]] ; then
    net=wlan0;
  elif [[ $(ifconfig|grep -c eth0) -ne "0" ]] ; then
    net=eth0;
  fi
 
  old_rcv=$(cat /sys/class/net/${net}/statistics/rx_bytes)
  old_snd=$(cat /sys/class/net/${net}/statistics/tx_bytes)
  sleep 1
  new_rcv=$(cat /sys/class/net/${net}/statistics/rx_bytes)
  new_snd=$(cat /sys/class/net/${net}/statistics/tx_bytes)

  size_rcv=$[${new_rcv} - ${old_rcv}]
  size_snd=$[${new_snd} - ${old_snd}]

  if [[ "${size_rcv}" -lt "${mib}" ]] ; then
    rcv_speed=$(printf "%1.2f\n" $(echo "scale=2; (${new_rcv} - ${old_rcv}) / ${kib}" | bc)) 
  else
    rcv_speed=$(printf "%1.2f\n" $(echo "scale=2; (${new_rcv} - ${old_rcv}) / ${mib}" | bc)) 
  fi

  if [[ "${size_snd}" -lt "${mib}" ]] ; then
    snd_speed=$(printf "%1.2f KiB/s\n" $(echo "scale=2; (${new_snd} - ${old_snd}) / ${kib}" | bc))
  else
    snd_speed=$(printf "%1.2f MiB/s\n" $(echo "scale=2; (${new_snd} - ${old_snd}) / ${mib}" | bc))
  fi

  echo -e "[ ${rcv_speed}/${snd_speed} | "
else
  echo -e "[ Network Down | "
fi
}

function disk {
  root=$(df -P | awk '/root/ { print $5 }')
  home=$(df -P | awk '/home/ { print $5 }')
  echo "${root}/${home} | "
}

function newmail {
  box=$(find ${HOME}/Mail/GMail/INBOX/new -type f | wc -l)
  box2=$(find ${HOME}/Mail/personal/INBOX/new -type f | wc -l)
  echo -e "${box}/${box2} | "
}

function uptime_short {
up=$(</proc/uptime)
u=${up%%.*}

m=$[u/60%60]
h=$[u/3600%24]
d=$[u/60/60/24]

if [[ "${d}" -gt "0" ]] ; then
  echo -e "${d}d ${h}:${m} | "
else
  echo -e "${h}:${m} | "
fi
}

function date_mute { 
	d=$(date +'%d/%m/%y %H:%M')
	dm=$(date +'%H:%M')
	vol=$(amixer -c 0 get Master | awk '/^  Mono:/ { print $3 }')
	if [ "${vol}" -eq "0" ]; then
		echo -e "--Mute-- ${dm} ]"
	else
		echo "${d} ]" 
	fi
}

while true; do
  xsetroot -name "$(netstatus)$(disk)$(newmail)$(uptime_short)$(date_mute)"
  sleep 1
done
