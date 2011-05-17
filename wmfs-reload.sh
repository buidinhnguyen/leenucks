#!/bin/bash

for pid in `pgrep conky`; do kill -9 $pid; done &&
for pid in `pgrep dzen2`; do kill -9 $pid; done &&
wmfs -c reload
