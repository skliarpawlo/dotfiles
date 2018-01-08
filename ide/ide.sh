#!/usr/bin/env zsh

ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

docker build -t tbcode/$1 --build-arg SUBDIR=$1 .
docker run -it -e DISPLAY=$ip:0 -e SUBDIR=$1 tbcode/$1 bash
