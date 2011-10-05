#!/bin/bash
#
# TODO
# rewrite using jshon ("http://kmkeen.com/jshon") instead of using awk grep sed tr 
#
# source Google_OAuth2.sh
Google_OAuth2_sh=$(which Google_OAuth2.sh)
(( $? != 0 )) && echo "Unable to locate Google_OAuth2.sh. Put it in PATH." && exit 1
source "${Google_OAuth2_sh}"

OAUTH_TOKEN="$(awk '/^access/ { print $2 }' ${DATADIR}/access_token )"

# get the unread count for Google Reader using magic
curl -s -H "Authorization: OAuth ${OAUTH_TOKEN}" "https://www.google.com/reader/api/0/unread-count?allcomments=false&output=json" |\
tr -d '\n' |\
tr '{' '\n' |\
grep 'id.:.feed/' |\
sed 's/.*"count":\([0-9]*\),".*/\1/' |\
grep "^[0-9]*$" |\
grep -v "^$" |\
tr '\n' '+' |\
sed 's/\(.*\)+/\1\n/' |\
bc 

# vim:fenc=utf-8:nu:ai:si:et:ts=2:sw=2:
