 #!/bin/bash
#
# most used apps via dmenu

PATH=${PATH}:${HOME}/bin

apps="a: google-chrome\nr: albumbler\ns: gimp\nt: leave.sh\nd: kb_switch.sh\nq: libreoffice\nw: gajim\nf: gvba\np: virtualbox\nz: GMail\nx: Google Reader"

if [[ -f "$HOME/.dmenurc" ]]; then
	. "$HOME/.dmenurc"
else
	DMENU='dmenu -i'
fi

choice="$(echo -e ${apps} | $DMENU | cut -d ':' -f 1)"

case "${choice}" in
	a) google-chrome                       ;;
	r) albumbler                           ;;
	s) gimp                                ;;
	t) leave.sh                            ;;
	d) kb_switch.sh                        ;;
	q) libreoffice -nologo                 ;;
	w) gajim                               ;;
	f) gvba                                ;;
	p) virtualbox                          ;;
	z) xdg-open "http://www.gmail.com"     ;;
	x) xdg-open "http://reader.google.com" ;;  
esac

