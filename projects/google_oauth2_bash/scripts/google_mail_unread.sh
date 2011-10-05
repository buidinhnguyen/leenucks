#!/bin/bash
#
# TODO
# api -> json-feed instead of atom-feed
# rewrite using jshon ("http://kmkeen.com/jshon") instead of using awk grep sed tr 
#
# source Google_OAuth2.sh
Google_OAuth2_sh=$(which Google_OAuth2.sh)
(( $? != 0 )) && echo "Unable to locate Google_OAuth2.sh. Put it in PATH." && exit 1
source "${Google_OAuth2_sh}"

OAUTH_TOKEN="$(awk '/^access/ { print $2 }' ${DATADIR}/access_token )"

# get the unread count for GMail using magic
curl -s -H "Authorization: OAuth ${OAUTH_TOKEN}" "https://mail.google.com/mail/feed/atom" |\
sed -e 's/<\// /g;s/>/ /g' |\
awk '/^<fullcount/ { print $2 }'

# vim:fenc=utf-8:nu:ai:si:et:ts=2:sw=2:
