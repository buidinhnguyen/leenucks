#!bin/sh
if [[ -z "$(pgrep mpd)" ]] ; then                   # mpd
  mpd ${XDG_CONFIG_HOME}/mpd/mpd.conf
fi
if [[ -z "$(pgrep mpdcron)" ]] ; then               # mpdcron
  mpdcron
fi
eval $(dbus-launch --sh-syntax --exit-with-session) # dbus
eval $(cat ${HOME}/.fehbg)                          # wallpaper
xsetroot -cursor_name left_ptr                      # cursor
xset -dpms s off                                    # disable screensaver and energy settings
urxvtd -q -f -o                                     # start urxvt daemon
xrdb -load ${HOME}/.Xdefaults                       # load Xdefaults
xset fp+ /usr/share/fonts/local                     # add local fonts
xbindkeys &                                         # multimedia keys
parcellite -nd &                                    # clipboard manager 
statnot ~/.config/statnot/config.py&

exec startdwm                                       # dwm

