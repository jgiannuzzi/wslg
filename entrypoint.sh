#!/bin/bash

set -ex

umask 0000
mkdir -p /tmp/.X11-unix
mount --bind /mnt/wslg/.X11-unix /tmp/.X11-unix
socat -dd tcp-listen:3389,fork,reuseaddr unix-connect:/mnt/wslg/rdp.sock &
rm /mnt/wslg/*.log
#tail -F /mnt/wslg/{pulseaudio,stderr,weston,wlog}.log &
tail -F /mnt/wslg/{weston,wlog}.log &
exec "$@"
