#!/bin/bash
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

# vim:fenc=utf-8:nu:ai:si:et:ts=2:sw=2:
