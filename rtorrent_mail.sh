#!/bin/sh
echo "$(date) : $1 - Download completed." | mutt -s "[rtorrent] - Download completed : $1" hmo.gsm@gmail.com
