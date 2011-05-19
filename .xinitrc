#!bin/sh
if [[ -z "$(pgrep mpd)" ]] ; then                   # mpd
  mpd ${XDG_CONFIG_HOME}/mpd/mpd.conf
fi
if [[ -z "$(pgrep cow-notify)" ]] ; then            # notification daemon
  cow-notify &
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
setxkbmap gb colemak                                # colemak layout
xset r 66

~/bin/dwmstatus &                                   # statusbar

exec startdwm                                       # dwm

