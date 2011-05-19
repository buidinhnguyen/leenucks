#!/bin/sh
rm -rf src/
makepkg -g > md5sums
makepkg -fi
