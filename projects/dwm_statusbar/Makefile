
CC=gcc
CFLAGS= -std=c99 -pedantic -Wall -Os -s -lX11 dwmstatus.c -o dwmstatus

# comment to disable

# libmpd adds ~1mb mem usage
WITH_MPD=-DUSE_MPD -lmpd

all:
	${CC} ${CFLAGS} ${WITH_MPD}

clean:
	rm dwmstatus
