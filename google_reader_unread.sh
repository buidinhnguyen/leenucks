#!/bin/bash
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.
#
# Requirements:
# curl

curl -s -H "Authorization: OAuth ${OAUTH_TOKEN}" "https://www.google.com/reader/api/0/unread-count?allcomments=false&output=json" | tr '{' '\n' | grep 'id.:.feed/' | sed 's/.*"count":\([0-9]*\),".*/\1/' | grep -E "^[0-9]+$" | tr '\n' '+' | sed 's/\(.*\)+/\1\n/' | bc
