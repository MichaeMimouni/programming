#!/bin/bash

set -e

[[ $# -lt 1 ]] && {
  echo "$0 <action> <args>";
  exit 2;
}

_Crypt() {
  [[ $# -eq 1 ]] || {
    echo "missing <directory>";
    exit 2;
  }

  local Dir="$1"

  [[ -d "$Dir" ]] || {
    echo "argument '$Dir' is not a directory";
    exit 2;
  }

  local Name=`basename "$Dir"`
  local Output="${Name}.tar.enc"

  echo "Output to $Output"

  tar -C $Dir -cz -f - -- "." | openssl enc -aes256 -out "$Output"
}

_Decrypt() {
  [[ $# -eq 2 ]] || {
    echo "missing <archive> <dir>"
    exit 2
  }

  local Archive="$1"
  local Dir="$2"

  [[ -d "$Dir" ]] && {
    echo "argument '$Dir' directory already exists"
    exit 2
  }

  mkdir -pv "$Dir"

  echo "Output to $Dir"

  cat $Archive |openssl enc -aes256 -d | tar -C $Dir -zxf - 
}

Action="$1"
shift

case "$Action" in
  -c) _Crypt $@;;
  -d) _Decrypt $@;;
  *) echo "bad action '$Action'" && exit 2;;
esac
