#!/bin/bash
#
# Requirements:
#  - curl
#  - jshon (http://kmkeen.com/jshon/)
#  - sed
#  - xdg-open
#
# TODO:
#  multiple accounts (?)
#

## hardcoded strings
DATADIR="${XDG_DATA_HOME:-${HOME}/.local/share}/google_oauth2"
CONFDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/google_oauth2"
CONFIG="${CONFDIR}/ggloauthrc"
# register your client in Google APIs console (http://code.google.com/apis/console#access) and change the following:
CLIENT_ID="1066434597262.apps.googleusercontent.com"
CLIENT_SECRET="iDotuISm0gjN-TGMVP47jop5"

# test for needed directories
[[ ! -d "${DATADIR}" ]] && mkdir -p "${DATADIR}"
[[ ! -d "${CONFDIR}" ]] && mkdir -p "${CONFDIR}"

# configfile exists? get variables
[[ -e "${CONFIG}" ]] && AUTH="$(jshon -e 'authorization_granted' < ${CONFIG})"
[[ -e "${CONFIG}" ]] && REFRESH_TOKEN="$(jshon -e 'refresh_token' < ${CONFIG} | sed -e 's/"//g')"

## authorize the application
# look for scopes in Google APIs documentation
# this example: Access to Google Reader export, Google Reader API && gmail feed
### change it accordingly and don't forget to include %20 when using multiple scopes ###
token_auth() {
	xdg-open "https://accounts.google.com/o/oauth2/auth?\
	client_id=${CLIENT_ID}&\
	redirect_uri=urn:ietf:wg:oauth:2.0:oob&\
	response_type=code&\
	scope=https://www.google.com/reader/subscriptions/export%20https://www.google.com/reader/api/%20https://mail.google.com/mail/feed/atom"
}

## get the first tokens, grant the access and delete the unneccessary files
token_get() {
curl -s "https://accounts.google.com/o/oauth2/token" \
	-d "client_id=${CLIENT_ID}" \
	-d "client_secret=${CLIENT_SECRET}" \
	-d "code=${RESPONSE_CODE}" \
	-d "redirect_uri=urn:ietf:wg:oauth:2.0:oob" \
	-d "grant_type=authorization_code" \
	-o "${CONFDIR}/tokens"
  
	[[ -e "${DATADIR}/access_token" ]] && rm "${DATADIR}/access_token"

	ACCESS_TOKEN=$(jshon -e 'access_token' < "${CONFDIR}/tokens")
	EXPIRY_TIME=$(jshon -e 'expires_in' < "${CONFDIR}/tokens")

	echo "{" > "${DATADIR}/access_token"
	echo " \"access_token\" : ${ACCESS_TOKEN}," >> "${DATADIR}/access_token"
	echo " \"expires_in\" : ${EXPIRY_TIME}" >> "${DATADIR}/access_token"
	echo "}" >> "${DATADIR}/access_token"

	REFRESH_TOKEN="$(jshon -e 'refresh_token' < "${CONFDIR}/tokens" )"

	echo "{" > "${CONFIG}"
	echo " \"refresh_token\" : ${REFRESH_TOKEN}," >> "${CONFIG}"
	echo " \"authorization_granted\" : \"yes\"" >> "${CONFIG}"
	echo "}" >> "${CONFIG}"

	echo ""
	echo "Configfile ${CONFIG} created"

	rm "${CONFDIR}/tokens"
}

## delete the old access token and refresh your access token
token_refresh() {
	[[ -e "${DATADIR}/access_token" ]] && rm "${DATADIR}/access_token"

	curl -s https://accounts.google.com/o/oauth2/token \
	-d "client_id=${CLIENT_ID}" \
	-d "client_secret=${CLIENT_SECRET}" \
	-d "refresh_token=${REFRESH_TOKEN}" \
	-d "grant_type=refresh_token" \
	-o "${DATADIR}/access_token"
}

## Start the program
# does a configfile already exist? if no, then get authorized and get the tokens
if [[ ! -e "${CONFIG}" ]] ; then
	# Are we using X?
	X=$(ps --no-headers -C X)
	[[ -z "${X}" ]] && echo "Need X, exiting" && exit 1
  
	token_auth
	echo -e "Copy and paste the authorization code and press Enter:"
	read -rs RESPONSE_CODE
	token_get
	echo "access_token:  ${DATADIR}/access_token"
	echo "refresh_token: ${CONFIG}"
fi

# access token is expired? get a new one
EXPIRY=$(jshon -e 'expires_in' < ${DATADIR}/access_token )
FILEAGE=$(($(date +%s) - $(stat -c '%Y' "${DATADIR}/access_token")))
(( "${FILEAGE}" > "${EXPIRY}" )) && token_refresh

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:
