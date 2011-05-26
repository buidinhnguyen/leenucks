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

source Google_OAuth2.sh

OAUTH_TOKEN="$(awk '/^access/ { print $2 }' ${DATADIR}/access_token )"

curl -s -H "Authorization: OAuth ${OAUTH_TOKEN}" "https://mail.google.com/mail/feed/atom" | sed -e 's/<\// /g;s/>/ /g' | awk '/^<fullcount/ { print $2 }'
