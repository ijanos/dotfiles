if [[ `tty` == "/dev/tty1" ]]; then
  setopt no_bgnice
  startx > /tmp/startx.log 2>&1 &!
  logout
fi
