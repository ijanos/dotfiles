#!/bin/bash

URL=$1
MSG="Moooo - $1"

wget $URL -O /tmp/original

while true; do
    wget $URL -O /tmp/new --user-agent="Hiperszuper-eredmenyfigyelo-script"
    diff -i -b -B -q /tmp/original /tmp/new
    if [ ! $? -eq 0 ]; then
        figlet $MSG|cowsay -n|xmessage -file - -center
        exit
    fi
    sleep 50
done
