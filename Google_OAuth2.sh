#!/bin/bash
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.
#
# Requirements:
#	curl
#	xdg-open
#	grep
#	sed

#
# TODO:
#	Functions
#	if-else-fi-statements
#

## hardcoded strings
DATADIR="${XDG_DATA_HOME:-$HOME/.local/share}/google_oauth2"
CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}/google_oauth2"
# register your client in Google APIs console (http://code.google.com/apis/console#access)
CLIENT_ID=""
CLIENT_SECRET=""

if [[ -e "${CONFDIR}/refresh_token" ]] ; then
	REFRESH_TOKEN="$(awk '/^refresh/ { print $2 }' ${CONFDIR}/refresh_tokens)"
else
	REFRESH_TOKEN=""
fi

if [[ ! -d "${DATADIR}" ]] ; then
	mkdir "${DATADIR}"
fi

if [[ ! -d "${CONFDIR}" ]] ; then
	mkdir "${CONFDIR}"
fi

## access token
xdg-open "https://accounts.google.com/o/oauth2/auth?\
client_id=&\
redirect_uri=urn:ietf:wg:oauth:2.0:oob&\
response_type=code&\
scope="                                                 # look for scopes in Google APIs documentation

#
# let the user copy the resulting authorization code and use that one
#

## get the tokens
curl https://accounts.google.com/o/oauth2/token \
-d "client_id= " \
-d "client_secret= " \
-d "code= " \
-d "redirect_uri=urn:ietf:wg:oauth:2.0:oob" \
tr ',' '\n' \
grep -v expires \
grep -v type \
sed -e 's#"##g;s#{##g;s#}##g;s#%##g;s#:# #g' \
> ${CONFDIR}/tokens

grep refresh ${CONFDIR}/tokens > ${CONFDIR}/refresh_token && chmod 0600 ${CONFDIR}/refresh_token
grep access ${CONFDIR}/tokens > ${DATADIR}/access_token && chmod 0600 ${DATADIR}/access_token

rm ${CONFDIR}/tokens

## refresh your access token
curl https://accounts.google.com/o/oauth2/token 
-d "client_id=" \
-d "client_secret=" \
-d "refresh_token=" \
-d "grant_type=refresh_token"

