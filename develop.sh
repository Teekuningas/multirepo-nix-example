#!/usr/bin/env bash

checkout () {
  if [ ! -d "$1" ] ; then
    git clone $2 $1
  else
    git -C $1 pull $2
  fi
}

mkdir -p develop
for source in $(cat SOURCES); do
  url=${source#*:}
  repo=$(basename $url)
  name=${repo%.*}
  path=$(realpath ./develop/$name)
  checkout $path $source
done


