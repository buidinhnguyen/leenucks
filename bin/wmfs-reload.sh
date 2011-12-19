#!/bin/sh

for pid in $(pgrep conky); do kill -9 $pid; done &&
for pid in $(pgrep dzen2); do kill -9 $pid; done &&
wmfs -c reload

# vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
