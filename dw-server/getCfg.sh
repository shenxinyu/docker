#!/bin/sh

set -e
if [ ! -n "$1" ]; then
    read -p "input your username: " username
else
    username=$1
fi

if [ ! -n "$2" ]; then
   read -s -p "input your password: " password
else
    password=$2
fi
echo "\r"

source ./dir.sh

#get server config
(
lpath=$dragon_root/data/game
rpath=$dev_root/data/game
mkdir -p $lpath
./getCfg.exp $username $password $rpath $lpath
ver=`cat Version.json |cut -d'"' -f2`
mv Version.json $lpath;cd $lpath;tar -zxf $ver.tar.gz;rm $ver.tar.gz
)

#get assets config
(
lpath=$dragon_root/docroot/assets/config
rpath=$dev_root/docroot/assets/config
mkdir -p $lpath
./getCfg.exp $username $password $rpath $lpath
ver=`cat Version.json |cut -d'"' -f2`
mv Version.json $lpath;cd $lpath;tar -zxf $ver.tar.gz;rm $ver.tar.gz
)
