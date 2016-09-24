#!/bin/bash

function main() {
  logd "Entered main script."
  ARGS="$@"

  logd "Running configuration script..."
  source $TOP/script/configure

  logd "Starting cli handling"
  local resultcode=0
  if [ -z "$1" ]; then
    run cli_handler interactive
  else
    run cli_handler direct $@
  fi
  local resultcode=$?

  logd "Exiting main script."
  return $resultcode
}

