#!bin/bash
mpd ${XDG_CONFIG_HOME}/mpd/mpd.conf                 # mpd
eval $(dbus-launch --sh-syntax --exit-with-session) # dbus
. ${HOME}/.fehbg                                    # wallpaper
xsetroot -cursor_name left_ptr                      # cursor
xset -dpms s off                                    # disable screensaver and energy settings
xrdb -load ${HOME}/.Xdefaults                       # load Xdefaults
xset fp+ /usr/share/fonts/local                     # add local fonts
xbindkeys &                                         # multimedia keys
parcellite -nd &                                    # clipboard manager 
setxkbmap gb colemak                                # colemak layout
xset r 66                                           # autorepeat

exec startdwm                                       # dwm
