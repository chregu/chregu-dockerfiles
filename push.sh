#!/bin/bash
PWD=`pwd`
NAME=`basename $PWD`
echo "pushing chregu/$NAME";
docker push chregu/$NAME
../created.sh
