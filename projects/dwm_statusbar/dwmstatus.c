/**
 * dwm status program
 *   shows mpd song title changes (updates every 5 seconds)
 *      (connection tries once a minute)
 */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <X11/Xatom.h>
#include <X11/Xlib.h>

// appending printf macro
#define aprintf(STR, ...) snprintf(STR+strlen(STR), 256-strlen(STR), __VA_ARGS__)
#define DEBUG(...) if(DEBUGGING) fprintf(stderr, __VA_ARGS__)

#define DATE_STRING "%d/%b/%Y - %H:%M"

static char DEBUGGING = 0;

typedef char (*status_f)(char *);

int num_big_status=0, num_normal_status=0;
status_f big_statuslist[16];
status_f normal_statuslist[16];

/////////////////////////////////////////////////////////////////////////////

#ifdef USE_MPD
#include <libmpd-1.0/libmpd/libmpd.h>

// checks the song playing on mpd
// if its new, displays a message
char get_mpdsong(char *status) {
	static MpdObj *mpd_connection = NULL;
	static char curSong[128];
	static int time_left=0, song_left=0;
	mpd_Song *temp = NULL;
	char tempstr[128];

	if( mpd_connection==NULL) {
		mpd_connection = mpd_new_default();
		mpd_connect(mpd_connection);
	}

	if( time_left<=0 ) {
		if( mpd_status_update(mpd_connection) ) {
			if( !mpd_connect(mpd_connection) )
				// wait a minute between retry attempts
				time_left=60;
		} else {
			// get current song
			temp = mpd_playlist_get_current_song(mpd_connection);
			if( temp ) {
				snprintf(tempstr,128,"%s - %s", temp->artist, temp->title);
				if( strncmp(curSong, tempstr, 128)!=0 ) {
					strncpy(curSong, tempstr, 128);
					// show new song for 5 seconds
					song_left=5;
				}
			}
			// wait 5 seconds before checking song again
			time_left=5;
		}
	}	else
		time_left--;
	
	if( song_left > 0 ) {
		song_left--;
		aprintf(status, "%s | ", curSong);
		return 1;
	}

	return 0;
}

#endif // USE_MPD

/////////////////////////////////////////////////////////////////////////////


int main(int argc, char **argv) {
	char stext[256];
	int i=0;
	time_t now;
	Display *dpy;
	Window root;

	if(!(dpy = XOpenDisplay(0))) {
		fprintf(stderr, "dwmstatus: cannot open display\n");
		return 1;
	}
	root = DefaultRootWindow(dpy);

	if( argc==2 && argv[1][0]=='-' && argv[1][1]=='v' ) {
		DEBUGGING=1;
		fprintf(stderr, "debugging enabled.\n");
	}

#ifdef USE_MPD
	big_statuslist[ num_big_status++ ] = get_mpdsong;
#endif

	while ( 1 )
		{
			stext[0]=0;

			for(i=0; i<num_big_status; i++)
				if( big_statuslist[i](stext) )
					break;

			// add the date/time to the end
			now = time(NULL);
			strftime(stext+strlen(stext), 256-strlen(stext), DATE_STRING, localtime( &now ) );

			XChangeProperty(dpy, root, XA_WM_NAME, XA_STRING,
					8, PropModeReplace, (unsigned char*)stext, strlen(stext));
			XFlush(dpy);

			// this needs to be low enough to catch notifications quickly
			sleep(1);
		}

	return 0;
}
