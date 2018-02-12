#!/usr/bin/env bash

cd /code && git pull && git checkout $BRANCH
pip3.5 install -r /code/$SUBDIR/requirements.txt
pip3.5 install -r /code/$SUBDIR/requirements_dev.txt

bash -c "$*"
