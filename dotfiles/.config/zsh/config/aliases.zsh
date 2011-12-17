##
# ${XDG_CONFIG_HOME}/zsh/aliases
# zsh aliases
##
# pacman {{{1
alias pacman='sudo pacman'
alias Qi='pacman -Qi'
alias Qm='pacman -Qm'
alias Qo='pacman -Qo'
alias Qs='pacman -Qs'
alias Qu='pacman -Qu'
alias Rns='pacman -Rns'
alias S='pacman -S'
alias Ss='pacman -Ss'
alias Su='pacman -Su'
alias Sy='pacman -Sy'
alias Syu='pacman -Syu'
alias U='pacman -U'
alias cower='cower --color=always'

# auto extensions {{{1
alias -s {txt,c,cpp,hs,py,pl}=${EDITOR}
alias -s {error,errors}='less'
alias -s {jpg,JPG,jpeg,JPEG,png,PNG,gif,GIF}='sxiv'
alias -s {mpg,mpeg,avi,ogm,ogv,wmv,m4v,mp4,mov,f4v,mkv,flv}='mplayer'
alias -s {mp3,ogg,wav,flac}='mplayer'
alias -s {odt,doc,docx,ppt,pptx,xls,xlsx,rtf}='libreoffice'
alias -s pdf='zathura'

# classics! {{{1
alias ls='ls -G --color=auto'
alias lsa='ls -G -a --group-directories-first'
alias lsl='ls -G -l -F -k -h --group-directories-first'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias dt='dmesg | tail -n 25'
alias rmd='rm -r'
alias ..='cd ..'
alias mem="free -m"
alias :q='exit'
alias :Q=':q'

# global {{{1
alias -g L='| less'
alias -g G='| egrep --color=auto -n'
alias -g W='| wgetpaste'

# things {{{1
alias ftp='ncftp'
alias ncm='ncmpcpp'
alias gox='startx & vlock'
alias feh='feh -g 1600x1000 -d' 
alias ud="sudo lsof | grep 'DEL.*lib' | cut -f 1 -d ' ' | sort -u"
alias torr="dtach -a /tmp/torr"
alias engage="play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +25  fade h 1 864000 1"

# vim {{{1
alias sv='sudo vim'

