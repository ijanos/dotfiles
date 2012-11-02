# Read this before using the script again
# http://blog.falconindy.com/articles/back-to-basics-with-x-and-systemd.html

if [[ `tty` == "/dev/tty1" ]]; then
  setopt no_bgnice
  startx > /tmp/startx.log 2>&1 &!
  sleep 10
  logout
fi
