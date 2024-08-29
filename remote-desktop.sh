#!/bin/sh

docker run -d \
  --cap-add=NET_ADMIN \
  --device /dev/net/tun \
  --name=rdesktop \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 3389:3389 \
  -v /var/run/docker.sock:/var/run/docker.sock `#optional` \
  -v /rdesktop/data:/config `#optional` \
  --device /dev/dri:/dev/dri `#optional` \
  --shm-size="1gb" `#optional` \
  --restart unless-stopped \
  lscr.io/linuxserver/rdesktop:latest
