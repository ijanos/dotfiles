#!/usr/bin/env python
# Adlbock hosts file generator

# Host Sources: https://github.com/dschuermann/ad-away/wiki/HostsSources

import time
import urllib.request

OUTPUT_FILE = "hosts.adblock"
URLS = ['http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext',
        'http://winhelp2002.mvps.org/hosts.txt',
        'http://sysctl.org/cameleon/hosts',
        'http://hosts-file.net/ad_servers.txt',
        'https://adaway.org/hosts.txt',
        'http://someonewhocares.org/hosts/hosts',
        'http://www.malwaredomainlist.com/hostslist/hosts.txt'
        ]


def download_hosts():
    hosts = ""
    for url in URLS:
        print("Downloading: " + url, end="...")
        try:
            response = urllib.request.urlopen(url, timeout=15)
            print("DONE")
        except Exception as e:
            print("Error during download: " + str(e))
            continue
        data = response.read()
        hosts += data.decode('utf-8')
    return hosts


if __name__ == "__main__":
    hosts = download_hosts()
    output = set()
    for line in hosts.splitlines():
        line = line.strip().split()
        if len(line) < 2:
            continue
        if '#' in line[0]:
            continue
        if 'localhost' in line[1]:
            continue
        if line[0] == '0.0.0.0':
            line[0] = '127.0.0.1'
        if '127.0.0.1' != line[0]:
            print("\tomitted: " + ' '.join(line))
            continue
        output.add(line[0] + ' ' + line[1] + '\n')

    print("Writing output file", end="...")
    f = open(OUTPUT_FILE, 'w')
    f.write("# Creation time: {}\n".format(time.strftime("%Y-%m-%d %H:%M:%S")))
    for line in output:
        f.write(line)
    print("DONE")
