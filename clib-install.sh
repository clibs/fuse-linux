#!/bin/bash

if ! $(which meson >/dev/null); then
  echo "error: Missing 'meson' command!" 1>&2
  exit 1
fi

if [ -z "${PREFIX}" ]; then
  PREFIX=/usr/local
fi

mkdir -p $PREFIX

## make !
{
  mkdir -p build
  cd build
  meson ..
  meson configure \
    --prefix=$PREFIX \
    -D utils=false \
    -D disable-mtab=true \
    -D examples=false \
    -D useroot=false
  ninja
  ninja install
}
