#!/usr/bin/env bash

prepare () {
  for source in $(cat SOURCES); do
    url=${source#*:}
    repo=$(basename $url)
    relpath=./develop/${repo%.*}
    if [[ ! -d $relpath ]]
    then
      continue
    fi
    path=$(realpath $relpath)

    gitinput=github:${url%.*}
    localinput=path:$path

    if grep -q $gitinput flake.nix; then
      sed -i "s&$gitinput&$localinput&g" flake.nix
    fi
  done
}

finish () {
  for source in $(cat SOURCES); do
    url=${source#*:}
    repo=$(basename $url)
    relpath=./develop/${repo%.*}
    if [[ ! -d $relpath ]]
    then
      continue
    fi
    path=$(realpath $relpath)

    gitinput=github:${url%.*}
    localinput=path:$path

    if grep -q $localinput flake.nix; then
      sed -i "s&$localinput&$gitinput&g" flake.nix
    fi
  done
}


echo "Preparing develop build.."
prepare

nix build --no-write-lock-file || true

echo "Returning everything back to normal.."
finish

