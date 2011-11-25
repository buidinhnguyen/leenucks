##
# ${XDG_CONFIG_HOME}/zsh/functions
# zsh functions
##
# check reddit for orangered and karma, perl-json and curl required {{{1
redditchk() {
	local COOKIE=${XDG_DATA_HOME}/reddit/redditsessioncookie
	local CRED=${XDG_CONFIG_HOME}/reddit/redditcredentials
	local redditusername redditpassword

	if [[ -r "${CRED}" ]]; then
		source "${CRED}"
	else
		echo "Error: missing ${CRED}"
		return 1
	fi

	if [[ ! -r "${COOKIE}" ]]; then
		curl -d user="${redditusername}" -d passwd="${redditpassword}" -c "${COOKIE}" -s -o /dev/null http://www.reddit.com/api/login && chmod 600 "${COOKIE}"
	fi

	curl -b "${COOKIE}" -s "http://www.reddit.com/user/$redditusername/about.json" |
	perl -MJSON -0777 -e '
		my $j = eval { decode_json(<>)->{data} } || (print("Reddit seems to be down.\n"), exit 1);
		print "Mail         : ", $j->{has_mail} ? "yes   http://www.reddit.com/message/unread/\n" : "no\n",
		"Link karma   : $j->{link_karma}\n",
		"Comment karma: $j->{comment_karma}\n"
	'
}

# is a page down? {{{1
down4me() {
	curl -s "http://www.downforeveryoneorjustme.com/$1" |\
	sed '/just you/!d;s/<[^>]*>//g' 
}

