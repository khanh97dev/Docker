#!/bin/sh

docker run -d \
  --cap-add=NET_ADMIN \
  --device /dev/net/tun \
  --name=rdesktop \
  --security-opt seccomp=unconfined \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 3389:3389 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /rdesktop/data:/config \
  --device /dev/dri:/dev/dri \
  --shm-size="1gb" \
  --restart unless-stopped \
  lscr.io/linuxserver/rdesktop:latest
