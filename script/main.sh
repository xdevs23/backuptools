#!/bin/bash

include reflect

function main() {
  ARGS="$@"

  if [ -z "$1" ]; then
    run cli_handler interactive
  else
    run cli_handler direct $@
  fi

  return 0
}

