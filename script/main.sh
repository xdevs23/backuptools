#!/bin/bash

function main() {
  logd "Entered main script."
  ARGS="$@"

  logd "Running configuration script..."
  source $TOP/script/configure

  adb_init
  if [ $? -ne 0 ]; then
    echo -e "${CL_YELLOW}Warning: adb initialization failed!" \
            "Uninitialized adb or undetected devices can lead to fatal errors." \
            "\nPlease type 'adb init' to try again." \
            "$CL_RESET"
  fi

  logd "Starting cli handling"
  local resultcode=0
  if [ -z "$ARGS" ]; then
    run cli_handler interactive
  else
    run cli_handler direct $ARGS
  fi
  local resultcode=$?

  logd "Exiting main script."
  return $resultcode
}

