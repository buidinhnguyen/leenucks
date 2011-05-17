#!/bin/bash
#
# keymap switcher
#
###

if [[ -f "${HOME}/.dmenurc" ]]; then
  . "${HOME}/.dmenurc"
else
  DMENU='dmenu -i'
fi

choice="$(echo -e "a: GB Colemak\nr:US\ns:DE" | $DMENU | cut -d ':' -f 1)"

# keymap switch
case "${choice}" in 
  a) setxkbmap gb colemak && xset r 66 ;; 
  r) setxkbmap us && xset r 66         ;;
  s) setxkbmap de && xset r 66         ;;
esac

