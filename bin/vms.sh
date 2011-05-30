#!/bin/zsh
#
# get a list of vms you have in VirtualBox and start them via dmenu

vboxmanage startvm --type gui $(vboxmanage list vms |\
 sed -e 's/"//g' |\
 cut -f1 -d ' ' |\
 dmenu -i -fn "Proggyoptis-8" -nb "#f0f0f0" -nf "#757575" -sb "#6D2857" -sf "#f0f0f0" -p "VMs")\
 &>/dev/null
