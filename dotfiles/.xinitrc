#!bin/bash
if [[ ! -e "/tmp/clipbored.pid" ]] ; then
  clipbored                                         # clipboard manager
fi
if [[ -e "$(which mpd)" ]] ; then
	mpd ${HOME}/.config/mpd/mpd.conf                  # mpd
fi
eval $(dbus-launch --sh-syntax --exit-with-session) # dbus
if [[ -e "$(which bgs)" ]] ; then
	bgs ~/files/pics/kyuubee.png                      # wallpaper
fi
xsetroot -cursor_name left_ptr                      # cursor
xset -dpms s off                                    # disable screensaver and energy settings
urxvtd -q -f -o                                     # start urxvt daemon
xrdb -load ${HOME}/.Xdefaults                       # load Xdefaults
xset fp+ /usr/share/fonts/local                     # add local fonts
if [[ -e "$(which xbindkeys)" ]] ; then
	xbindkeys &                                       # multimedia keys
fi
if [[ -e "$(which keepass)" ]] ; then               # keepass
	keepass &
fi
if [[ -e "${HOME}/bin/dropbox.py" ]] ; then         # dropbox
	$(which python2) ${HOME}/bin/dropbox.py start
fi
setxkbmap gb colemak                                # colemak layout
xset r 66                                           # autorepeat

exec startdwm                                       # dwm
