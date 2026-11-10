
#!/bin/bash
set -eu

export DISPLAY=:1
export HOME=/root

mkdir -p /tmp/.X11-unix
Xvfb :1 -screen 0 1280x800x24 -ac &
sleep 2

dbus-launch --exit-with-session startxfce4 &
sleep 5

x11vnc -display :1 -localhost -nopw -forever \
  -shared -rfbport 5901 &

websockify --web=/usr/share/novnc/ \
  6080 localhost:5901
