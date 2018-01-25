#!/usr/bin/env bash

cd /code && git pull

emacs -fs &

bash -c "$*"
