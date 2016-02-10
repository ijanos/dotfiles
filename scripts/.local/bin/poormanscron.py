#!/usr/bin/env python

from subprocess import call
from random import randrange
from time import sleep, strftime

wakeups = [
    "07:03",
    "11:28",
    "12:47",
    "17:04",
    "21:12"
]

while True:
    sleep(20)
    current_time= strftime("%H:%M")
    if current_time in wakeups:
        sleep(randrange(45,200))
        print("\n\nWaking up at " + current_time + "\n\n")
        call("./curl.sh", shell=True)

