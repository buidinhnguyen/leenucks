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
#

# PATH for crontab
PATH="/home/uh/bin:${PATH}"
# source Google_OAuth2.sh
Google_OAuth2_sh=$(which Google_OAuth2.sh)
(( $? != 0 )) && echo "Unable to locate Google_OAuth2.sh. Put it in PATH." && exit 1
source "${Google_OAuth2_sh}"

DT=$(date +"%Y%m%d")

OAUTH_TOKEN="$(awk '/^access/ { print $2 }' ${DATADIR}/access_token )"
BACKUP_FILE="${HOME}/files/backups/Subscriptions-${DT}.opml"

# get the reader subscriptions as an opml file and save them in ~/files/backups as Subscriptions-YYYYMMDD.opml
curl -s -o "${BACKUP_FILE}" -H "Authorization: OAuth ${OAUTH_TOKEN}" "https://www.google.com/reader/subscriptions/export"

