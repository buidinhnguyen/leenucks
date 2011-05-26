#!/bin/bash
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

