##
# .zshrc
# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:ft=sh:fdm=marker:
##
# basics {{{1
autoload -U compinit zmv url-quote-magic
compinit
 
# keybindings {{{1
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line

# automagic url quoter {{{1
zle -N self-insert url-quote-magic

# options {{{1
setopt always_to_end
setopt autocd
setopt complete_in_word
setopt correctall
setopt extended_glob
setopt globdots
setopt histignorespace
setopt ignoreeof
setopt noclobber

# history {{{1
HISTFILE=~/.zsh-history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_all_dups hist_reduce_blanks \
hist_save_no_dups inc_append_history \
extended_history share_history multios

# keychain {{{1
#eval $(keychain --eval --agents ssh id_rsa)

# the prompt {{{1
#PROMPT=$'%n@%m %0(3c,%c,%~) %0(?,%{\e[0;32m%}:%),%{\e[0;31m%}:(%s)%b %# '
PROMPT=$'%# '

# aliases, completions, functions and variables {{{1
for file in ${XDG_CONFIG_HOME}/zsh/config/*.zsh ; do
	[[ -r "${file}" ]] && source "${file}"
done

# zsh-syntax-highlighting and zsh-history-substring-search {{{1
for ext in ${XDG_CONFIG_HOME}/zsh/extensions/*/*.zsh ; do 
	[[ -r "${ext}" ]] && source "${ext}"
done
