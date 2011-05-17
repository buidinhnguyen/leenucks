#!/bin/bash

TERM=$(which urxvt)
FETCH=$(which screenfetch)

if [[ -n "${TERM}" && -n "${FETCH}" ]] ; then
  ${TERM} -e ${FETCH} -s
else
  ${ZENI} --info --text "Redefine the terminal and/or install screenfetch!"
fi
