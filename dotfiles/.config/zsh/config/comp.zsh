##
# ${XDG_CONFIG_HOME}/zsh/comp
##
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:cd:*' menu yes select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:kill:*' menu yes selectG
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:processes' command 'ps -A'
zstyle ':completion:*:manuals' menu yes select
zstyle ':completion::complete:*' use-cache 1
