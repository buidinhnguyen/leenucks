 #!/bin/bash
#
# most used apps via dmenu

PATH=${PATH}:${HOME}/bin

apps="a: firefox\nr: chromium\ns: albumbler\nt: gimp\nd: leave.sh\nq: kb_switch.sh\nw: libreoffice\nf: gajim\np: gvba\nz: virtualbox\nx: GMail\nc: Google Reader"

if [[ -f "$HOME/.dmenurc" ]]; then
	. "$HOME/.dmenurc"
else
	DMENU='dmenu -i'
fi

choice="$(echo -e ${apps} | $DMENU | cut -d ':' -f 1)"

case "${choice}" in
	a) firefox                             ;;
	r) chromium                            ;;
	s) albumbler                           ;;
	t) gimp                                ;;
	d) leave.sh                            ;;
	q) kb_switch.sh                        ;;
	w) libreoffice -nologo                 ;;
	f) gajim                               ;;
	p) gvba                                ;;
	z) virtualbox                          ;;
	x) xdg-open "http://www.gmail.com"     ;;
	c) xdg-open "http://reader.google.com" ;;  
esac

