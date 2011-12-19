#!/bin/sh
# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
#
# Requirements:{{{1
#  - Google_OAuth2.sh
#  - curl
#  - sed
#  - awk
#  - jshon (http://kmkeen.com/jshon/)
#

# source Google_OAuth2.sh {{{1
Google_OAuth2_sh=$(which Google_OAuth2.sh)
$(( $? != 0 )) && echo "Unable to locate Google_OAuth2.sh. Put it in PATH." && exit 1
. "${Google_OAuth2_sh}"

OAUTH_TOKEN="$(jshon -e 'access_token' < ${DATADIR}/access_token )"

# get the unread count for GMail {{{1
curl -s -H "Authorization: Bearer ${OAUTH_TOKEN}" "https://mail.google.com/mail/feed/atom" |\
sed -e 's/<\// /g;s/>/ /g' |\
awk '/^<fullcount/ { print $2 }' ## fugly sed_awk_crap (parsing feeds sucks)
