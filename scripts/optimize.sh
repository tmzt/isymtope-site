#!/bin/bash

readonly SOURCE_DIR=$(dirname $BASH_SOURCE[0])
readonly ORIG_DIR="${SOURCE_DIR}/../site/_assets/img/pexels-orig/"
readonly OPT_DIR="${SOURCE_DIR}/../site/assets/img/pexels-opt/"

mkdir -p ${OPT_DIR}

jpegtran -copy comments > ${OPT_DIR}/triangular.jpg < ${ORIG_DIR}/triangular.jpeg
jpegtopnm < ${ORIG_DIR}/white-blank-notebook.jpeg |pnmtojpeg -quality 85 > ${OPT_DIR}/white-blank-notebook.jpg
jpegtopnm < ${ORIG_DIR}/building-windows.jpeg |pnmtojpeg -quality 85 > ${OPT_DIR}/building-windows.jpg
jpegtopnm < ${ORIG_DIR}/hallway-dome-interior.jpeg |pnmtojpeg -quality 85 > ${OPT_DIR}/hallway-dome-interior.jpg
jpegtopnm < ${ORIG_DIR}/white-hallway-geometric.jpeg |pnmtojpeg -quality 85 > ${OPT_DIR}/white-hallway-geometric.jpg
jpegtopnm < ${ORIG_DIR}/scalloped-wall.jpeg |pnmtojpeg -quality 85 > ${OPT_DIR}/scalloped-wall.jpg
jpegtopnm < ${ORIG_DIR}/concrete-structure.jpeg |pnmtojpeg -quality 85 > ${OPT_DIR}/concrete-structure.jpg

# jpegtopnm < ${ORIG_DIR}/red-swing.jpeg \
#     |pnmcut -height 2456
#     |pnmtojpeg -quality 85 > ${OPT_DIR}/red-swing.jpg
