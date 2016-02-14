#!/bin/bash
PWD=`pwd`
NAME=`basename $PWD`
echo "building chregu/$NAME";
docker build --rm   --no-cache=true -t chregu/$NAME .
