##
# .zshrc
# vim:fenc=utf-8:nu:ai:si:et:ts=2:sw=2:ft=sh:
##
# basics
autoload -U compinit promptinit zmv url-quote-magic
compinit
promptinit
prompt bart

# variables
export PATH="${PATH}:${HOME}/bin"
export BROWSER="firefox-nightly"
export LANG="en_US.utf8"
export LC_ALL="en_US.utf8"
export EDITOR="vim"

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# keybindings
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line

# automagic url quoter
zle -N self-insert url-quote-magic

# options
setopt always_to_end
setopt autocd
setopt complete_in_word
setopt correctall
setopt extended_glob
setopt globdots
setopt histignorespace
setopt ignoreeof
setopt noclobber

# history
HISTFILE=~/.zsh-history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups hist_reduce_blanks \
hist_save_no_dups inc_append_history \
extended_history share_history multios

# load aliases, completions and prompt
[[ -r ${XDG_CONFIG_HOME}/zsh/aliases    ]] && source "${XDG_CONFIG_HOME}/zsh/aliases"
[[ -r ${XDG_CONFIG_HOME}/zsh/comp       ]] && source "${XDG_CONFIG_HOME}/zsh/comp"
[[ -r ${XDG_CONFIG_HOME}/zsh/S60_prompt ]] && source "${XDG_CONFIG_HOME}/zsh/S60_prompt"

# keychain ssh-keys
eval $(keychain --eval --agents ssh id_rsa)
