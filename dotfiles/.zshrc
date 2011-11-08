##
# .zshrc
# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:ft=sh:
##
# basics
autoload -U compinit zmv url-quote-magic
compinit

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

# keychain
#eval $(keychain --eval --agents ssh id_rsa)

# load aliases, completions, functions, variables and finally the prompt
[[ -r ${XDG_CONFIG_HOME}/zsh/aliases    ]] && source "${XDG_CONFIG_HOME}/zsh/aliases"
[[ -r ${XDG_CONFIG_HOME}/zsh/comp       ]] && source "${XDG_CONFIG_HOME}/zsh/comp"
[[ -r ${XDG_CONFIG_HOME}/zsh/func       ]] && source "${XDG_CONFIG_HOME}/zsh/func"
[[ -r ${XDG_CONFIG_HOME}/zsh/var        ]] && source "${XDG_CONFIG_HOME}/zsh/var"
#PROMPT=$'%n@%m %0(3c,%c,%~) %0(?,%{\e[0;32m%}:%),%{\e[0;31m%}:(%s)%b %# '
PROMPT=$'%# '
