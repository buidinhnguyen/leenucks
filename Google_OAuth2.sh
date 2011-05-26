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
#	ps
#
#
# TODO:
#	rewrite using only curl to get the response code for authorizing the program
#	multiple accounts (?)
#

## hardcoded strings
DATADIR="${XDG_DATA_HOME:-$HOME/.local/share}/google_oauth2"
CONFDIR="${XDG_CONFIG_HOME:-$HOME/.config}/google_oauth2"
CONFIG="${CONFDIR}/ggloauthrc"
# register your client in Google APIs console (http://code.google.com/apis/console#access) and replace it
CLIENT_ID="560131576595.apps.googleusercontent.com"
CLIENT_SECRET="nMn36cHLp_ty20QoG0EuVPfY"

# test for needed directories
[[ ! -d "${DATADIR}" ]] && mkdir "${DATADIR}"
[[ ! -d "${CONFDIR}" ]] && mkdir "${CONFDIR}"

# configfile exists? get variables
[[ -e "${CONFIG}" ]] && AUTH="$(awk '/^authorization/ { print $2 }' ${CONFIG})"
[[ -e "${CONFIG}" ]] && REFRESH_TOKEN="$(awk '/^refresh/ { print $2 }' ${CONFIG})"

## authorize the application
# look for scopes in Google APIs documentation
# this example: Access to Google Reader export, Google Reader API && gmail unread feed
### change it accordingly and don't forget to include %20 when using multiple scopes ###
token_auth() {
	xdg-open "https://accounts.google.com/o/oauth2/auth?\
	client_id=${CLIENT_ID}&\
	redirect_uri=urn:ietf:wg:oauth:2.0:oob&\
	response_type=code&\
	scope=https://www.google.com/reader/subscriptions/export%20https://www.google.com/reader/api/%20https://mail.google.com/mail/feed/atom"
}

## get the first tokens and grant the access
token_get() {
	curl -s https://accounts.google.com/o/oauth2/token \
	-d "client_id=${CLIENT_ID}" \
	-d "client_secret=${CLIENT_SECRET}" \
	-d "code=${RESPONSE_CODE}" \
	-d "redirect_uri=urn:ietf:wg:oauth:2.0:oob" \
	-d "grant_type=authorization_code" |\
	tr ',' '\n' |\
	grep -v type |\
	sed -e 's#"##g;s#{##g;s#}##g;s#%##g;s#:# #g' \
	> "${CONFDIR}/tokens"

	[[ -e "${DATADIR}/access_token" ]] && rm "${DATADIR}/access_token"

	grep -A2 "access" "${CONFDIR}/tokens" > "${DATADIR}/access_token"
	chmod 0600 "${DATADIR}/access_token"

	grep "refresh" "${CONFDIR}/tokens" > "${CONFIG}"
	chmod 0600 "${CONFIG}"

	rm "${CONFDIR}/tokens"

	echo "authorization_granted yes" >> "${CONFIG}"
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
	sed -e 's#"##g;s#{##g;s#}##g;s#%##g;s#:# #g' \
	> "${DATADIR}/access_token"
}

## Start the program
## rewrite using plain-curl ~
# Are we using X?
X=$(ps --no-headers -C X)
[[ -z "${X}" ]] && echo "Need X server for now, exiting" && exit 1

# does a configfile already exist? if no, then get authorized and get the tokens
if [[ ! -e "${CONFIG}" ]] ; then
	token_auth
	echo -e "Copy and paste the authorization code and press Enter:"
	read -rs RESPONSE_CODE
	token_get
	echo "access_token:  ${DATADIR}/access_token"
  echo "refresh_token: ${CONFIG}"
fi

# access token is expired? get a new one
EXPIRY=$(awk '/^exp/ { print $2 }' ${DATADIR}/access_token )
FILEAGE=$(($(date +%s) - $(stat -c '%Y' "${DATADIR}/access_token")))
(( "${FILEAGE}" > "${EXPIRY}" )) && refresh_token
