#!/bin/bash

readonly SOURCE_DIR=$(dirname $BASH_SOURCE[0])
readonly ORIG_DIR="${SOURCE_DIR}/../site/_assets/img/pexels-orig/"
readonly OPT_DIR="${SOURCE_DIR}/../site/assets/img/pexels-opt/"

readonly GID=$(id -g)

echo "Processing images..."
pushd ${SOURCE_DIR}/..
    docker run -u ${UID}:${GID} -v `pwd`:/site contraslash/alpine-pillow python /site/scripts/shrink.py
popd

echo "Copying header image"
jpegtran -copy comments > ${OPT_DIR}/triangular.jpeg < ${ORIG_DIR}/triangular.jpeg
