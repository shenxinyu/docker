#!/bin/sh

source ./dir.sh

docker run -d -p 2222:22 -p 80:80 -v $dev_root:/root/dev shenxinyu/rrx-server
docker ps
