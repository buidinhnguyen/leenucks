#!/bin/zsh
#
# most used apps via dmenu

IFS=$'\t\n'
PATH=${PATH}:${HOME}/bin

apps="google-chrome
albumbler
gimp
leave.sh
kb_switch.sh
libreoffice
gajim
gvba
virtualbox
vms.sh"

$(echo ${apps} | dmenu -i -fn 'Proggyoptis-8' -nb '#f0f0f0' -nf '#757575' -sb '#6D2857' -sf '#f0f0f0' )

