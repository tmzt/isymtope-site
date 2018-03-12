#!/bin/bash

which cobalt || cargo install cobalt-bin --features=sass --force
which sfz || cargo install sfz --force

pushd site
    cobalt build
    sed -ie 's#https://isymtope.org/#http://localhost:5000/#g' _site/index.html
    sed -ie 's#http://localhost:5000/playground#http://localhost:3000#g' _site/index.html
    sfz _site -r
popd
