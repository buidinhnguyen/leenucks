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
#	if-else-statements
#	rewrite using only curl for authentication and no xdg-open
#

## hardcoded strings
DATADIR="${XDG_DATA_HOME:-$HOME/.local/share}/google_oauth2"
CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}/google_oauth2"
# register your client in Google APIs console (http://code.google.com/apis/console#access) and replace it
CLIENT_ID="560131576595.apps.googleusercontent.com"
CLIENT_SECRET="nMn36cHLp_ty20QoG0EuVPfY"

# test fo variable REFRESH_TOKEN && needed directories
[[ -e "${CONFDIR}/refresh_token" ]] && REFRESH_TOKEN="$(awk '/^refresh/ { print $2 }' ${CONFDIR}/refresh_token)"
[[ ! -d "${DATADIR}" ]] && mkdir "${DATADIR}"
[[ ! -d "${CONFDIR}" ]] && mkdir "${CONFDIR}"

## authorize the application
# look for scopes in Google APIs documentation
token_auth() {
	xdg-open "https://accounts.google.com/o/oauth2/auth?\
	client_id=${CLIENT_ID}&\
	redirect_uri=urn:ietf:wg:oauth:2.0:oob&\
	response_type=code&\
	scope="
}

## get the tokens
token_get() {
	curl -s https://accounts.google.com/o/oauth2/token \
	-d "client_id=${CLIENT_ID}" \
	-d "client_secret=${CLIENT_SECRET}" \
	-d "code=${RESPONSE_CODE}" \
	-d "redirect_uri=urn:ietf:wg:oauth:2.0:oob" |\
	tr ',' '\n' |\
	grep -v expires |\
	grep -v type |\
	sed -e 's#"##g;s#{##g;s#}##g;s#%##g;s#:# #g' \
	> "${CONFDIR}/tokens"

	if [[ -e "${DATADIR}/access_token" ]] ; then
		rm "${DATADIR}/access_token"
	fi

	grep "access" "${CONFDIR}/tokens" > "${DATADIR}/access_token"
	chmod 0600 "${DATADIR}/access_token"

	grep "refresh" "${CONFDIR}/tokens" > "${CONFDIR}/refresh_token"
	chmod 0600 "${CONFDIR}/refresh_token"

	rm "${CONFDIR}/tokens"
}

## delete the old access token and refresh your access token
token_refresh() {
	[[ -e "${DATADIR}/access_token" ]] && rm "${DATADIR}/access_token"

	curl -s https://accounts.google.com/o/oauth2/token \
	-d "client_id=${CLIENT_ID}" \
	-d "client_secret=${CLIENT_SECRET}" \
	-d "refresh_token=${REFRESH_TOKEN}" \
	-d "grant_type=refresh_token" |\
	tr ',' '\n' |\
	grep -v expires |\
	grep -v type |\
	sed -e 's#"##g;s#{##g;s#}##g;s#%##g;s#:# #g' \
	> "${DATADIR}/access_token"
}

## rewrite using plain-curl ~
# Are we using X?
#X=$(ps --no-headers -C X)
#[[ -z "${X}" ]] && echo "Need X server for now, exiting" && exit 1

#token_auth
# let the user copy the resulting authorization code and use that
#token_get
#token_refresh
