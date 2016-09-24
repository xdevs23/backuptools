#!/bin/bash

function main() {
  logd "Entered main script."
  ARGS="$@"

  logd "Running configuration script..."
  source $TOP/script/configure

  logd "Starting cli handling"
  if [ -z "$1" ]; then
    run cli_handler interactive
  else
    run cli_handler direct $@
  fi

  logd "Exiting main script."
  return 0
}

