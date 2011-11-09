#!/bin/bash
#
# Requirements
#  - Google_OAuth2.sh
#  - curl
#  - jshon (http://kmkeen.com/jshon/)
#  - sed
#  - wc
#
# source Google_OAuth2.sh
Google_OAuth2_sh=$(which Google_OAuth2.sh)
(( $? != 0 )) && echo "Unable to locate Google_OAuth2.sh. Put it in PATH." && exit 1
source "${Google_OAuth2_sh}"

OAUTH_TOKEN="$(jshon -e 'access_token' < ${DATADIR}/access_token )"

uID=$(curl -s -H "Authorization: OAuth ${OAUTH_TOKEN}" \
	"https://www.google.com/reader/api/0/user-info" |\
	jshon -e 'userId' |\
	sed -e 's/"//g'
)

# get the unread count for Google Reader using magic
curl -s -H "Authorization: OAuth ${OAUTH_TOKEN}" \
"https://www.google.com/reader/api/0/stream/contents/user/${uID}/state/com.google/reading-list?xt=user/${uID}/state/com.google/read&n=9999" |\
jshon -e 'items' -a -e 'title' |\
wc -l

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:
