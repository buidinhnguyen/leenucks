#!/bin/bash

echo "The databases are being optimized..."
echo "Please wait!"
for i in $(find ~/.mozilla -name \*.sqlite); do sqlite3 $i vacuum; done
for i in $(find ~/.mozilla -name \*.sqlite); do sqlite3 $i reindex; done
echo "Firefox databases optimized!"
