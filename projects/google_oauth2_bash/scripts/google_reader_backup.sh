#!/bin/sh
# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
#
# Requirements: {{{1
#  - Google_OAuth2.sh
#  - curl
#  - jshon (http://kmkeen.com/jshon/)
#
# PATH for crontab {{{1
PATH="/home/uh/bin:${PATH}"
# source Google_OAuth2.sh
Google_OAuth2_sh=$(which Google_OAuth2.sh)
$(( $? != 0 )) && echo "Unable to locate Google_OAuth2.sh. Put it in PATH." && exit 1
. "${Google_OAuth2_sh}"

# variables {{{1
DT=$(date +"%Y%m%d")
OAUTH_TOKEN="$(jshon -e 'access_token' < ${DATADIR}/access_token )"
BACKUP_FILE="${HOME}/files/backups/Subscriptions-${DT}.opml"

# get the reader subscriptions as an opml file and save them in ~/files/backups as Subscriptions-YYYYMMDD.opml {{{1
curl -s -o "${BACKUP_FILE}" -H "Authorization: Bearer ${OAUTH_TOKEN}" "https://www.google.com/reader/subscriptions/export"
