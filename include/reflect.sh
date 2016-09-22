#!/bin/bash

REFLECTORS_PATH="$TOP/include/reflectors"

export REFLECTOR_NAME=""
export REFLECTOR_ID=""

function reflectorName() {
  export REFLECTOR_NAME="$@"
}

function reflectorId() {
  export REFLECTOR_ID="$1"
}

function run() {
  reflectresult=0
  allargs="$@"
  reflector="$1"
  reflectargs="${allargs//$reflector /}"
  for sc in $(find $REFLECTORS_PATH/ -type f); do
    source $sc
    reflectresult=$?
    if [ ! $reflectresult -eq 0 ]; then
      echo -e "\033[91mReflector ${sc/$REFLECTOR_PATH\//} is invalid or failed!\033[0m"
      break
    fi
    if [ "$REFLECTOR_NAME" == "$reflector" ] ||
       [ "$REFLECTOR_ID"   == "$reflector" ]; then
      reflect $reflectargs
      break
    fi
  done
  clean_reflection
  return $reflectresult
}

function clean_reflection() {
  # Reset
  reflectorName
  reflectorId
}
