#!/usr/bin/env bash

# Host Sources: https://github.com/dschuermann/ad-away/wiki/HostsSources

HOSTFILE=hosts.adblock
TMPFILE=${HOSTFILE}.tmp
URLS=( 'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext'
       'http://winhelp2002.mvps.org/hosts.txt'
       'http://sysctl.org/cameleon/hosts'
       'http://hosts-file.net/ad_servers.txt'
       'https://adaway.org/hosts.txt'
       'http://someonewhocares.org/hosts/hosts'
      )

rm $HOSTFILE
rm $TMPFILE

for URL in ${URLS[@]}; do
    curl $URL >> $TMPFILE
done

grep -v "^#" $TMPFILE | grep -v localhost |tr "\t" " " | sed  's/0.0.0.0/127.0.0.1/g'| sed '/^$/d' | uniq > $HOSTFILE

rm $TMPFILE
