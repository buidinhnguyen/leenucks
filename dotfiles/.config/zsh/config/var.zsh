##
# ${XDG_CONFIG_HOME}/zsh/var
# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:ft=sh:
##

# ~/bin in ${PATH} {{{1
if [[ -z "$(echo ${PATH} | grep home)" ]] ; then
  export PATH="${HOME}/bin:${PATH}"
fi

# variables {{{1
export BROWSER="firefox"
export LANG="de_DE.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export EDITOR="vim"

# colors in less {{{1
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# clipbored {{{1
export CLIPBORED_DMENU_LISTMODE="vertical"
export CLIPBORED_DMENU_NORMAL_FG="#000000"
export CLIPBORED_DMENU_NORMAL_BG="#cccccc"
export CLIPBORED_DMENU_SELECT_FG="#0066ff"
export CLIPBORED_DMENU_SELECT_BG="#cccccc"
export CLIPBORED_DMENU_FONT="-*-proggyoptis-*-*-*-*-10-*-*-*-*-*-*-*"
export CLIPBORED_DMENU_LINES="15"
