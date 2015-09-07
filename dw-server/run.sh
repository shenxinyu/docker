#!/bin/sh

source ./dir.sh

docker run -d -p 8222:22 -p 80:80 -p 8001:8001 -v $dragon_root:/root/dragon-server-code -v $googledoc_root:/root/dragon-googledoc-config -v $actor_root:/root/actor shenxinyu/dw-server
docker ps
