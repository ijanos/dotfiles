#!/bin/sh
#
# List files with exactly one hard link number
#
# I use the files in this directory hard linked to their specific 
# locations, so I can tell which files are currently in use by the 
# number of hardlinks. If it is one, the file is not in use.

find .\
    -path "./.git/*" -prune -o\
    -path "./bin/*" -prune -o\
    -path "./archive/*" -prune -o\
    -name "README" -prune -o\
    -name "UNLICENSE" -prune -o\
    -name "unused.sh" -prune -o\
    -links 1 -print
