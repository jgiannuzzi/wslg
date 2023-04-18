#!/bin/bash

set -ex

umask 0000
rm -rf /mnt/wslg
chown wslg:wslg /mnt/wslg
mkdir -p /mnt/wslg/.X11-unix /mnt/wslg/runtime-dir /tmp/.X11-unix
mount --bind /mnt/wslg/.X11-unix /tmp/.X11-unix
socat -dd tcp-listen:3389,fork,reuseaddr unix-connect:/mnt/wslg/rdp.sock &
tail -F /mnt/wslg/{weston,wlog}.log &
exec "$@"
