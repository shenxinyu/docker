#!/bin/sh

source ./dir.sh

mkdir -p $root
git clone git@bitbucket.org:funplus/dragon-server-code.git $dragon_root
git clone git@bitbucket.org:funplus/dragon-googledoc-config.git $googledoc_root
git clone git@bitbucket.org:funplus/actor.git $actor_root
(
cd $dragon_root
git checkout dev
git pull
)
