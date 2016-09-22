#!/bin/bash

function main() {
  ARGS="$@"

  source $TOP/script/configure

  if [ -z "$1" ]; then
    run cli_handler interactive
  else
    run cli_handler direct $@
  fi

  return 0
}

