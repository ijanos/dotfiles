from glob import glob
from subprocess import run
from sys import argv

num = 1

for photo in glob("*.jpg"):
    cmd = ["jhead", "-ta+0:00:{}".format(num), photo]
    if len(argv) > 1 and argv[1] == "ok":
        run(cmd, check=True)
    else:
        print("DRY RUN " + ' '.join(cmd))
    num += 1
