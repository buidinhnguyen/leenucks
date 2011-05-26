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
# TODO:
# Rewrite 
# 

DT=$(date +"%Y%m%d")

OAUTH_TOKEN=$(awk '/^access_token/ { print $2 }' ${XDG_CONFIG_HOME}/google_oauth2/access_token)
BACKUP_FILE="${HOME}/files/backups/Subscriptions-${DT}.opml"

curl -s -o "${BACKUP_FILE}" -H "Authorization: OAuth ${OAUTH_TOKEN}" https://www.google.com/reader/subscriptions/export

