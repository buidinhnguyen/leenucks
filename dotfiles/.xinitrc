#!bin/bash
if [[ ! -e "/tmp/clipbored.pid" ]] ; then
  clipbored                                         # clipboard manager
fi
mpd ${HOME}/.config/mpd/mpd.conf                    # mpd
eval $(dbus-launch --sh-syntax --exit-with-session) # dbus
bgs ~/files/pics/kyuubee.png                        # wallpaper
xsetroot -cursor_name left_ptr                      # cursor
xset -dpms s off                                    # disable screensaver and energy settings
urxvtd -q -f -o                                     # start urxvt daemon
xrdb -load ${HOME}/.Xdefaults                       # load Xdefaults
xset fp+ /usr/share/fonts/local                     # add local fonts
xbindkeys &                                         # multimedia keys
keepass &                                           # keepass
dropboxd &                                          # dropbox
setxkbmap gb colemak                                # colemak layout
xset r 66                                           # autorepeat

exec startdwm                                       # dwm
