#!/usr/bin/env zsh

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

docker build -t tbcode/$1 --build-arg SUBDIR=$1 --build-arg BRANCH=$2 .
docker run -it -e DISPLAY=$ip:0 -e SUBDIR=$1 -e BRANCH=$2 tbcode/$1 bash
