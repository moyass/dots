#!/usr/bin/env bash

for i in /*; do
  if [[ -d $i  ]] ; then
    cd $i
    mr register -c ~/.vim/.mrconfig
    cd ..
  fi
done
