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
  allargs="$@"
  reflector="$1"
  reflectargs="${allargs//$reflector /}"
  for sc in $(ls $REFLECTORS_PATH/); do
    source $REFLECTORS_PATH/$sc
    if [ "$REFLECTOR_NAME" == "$reflector" ] ||
       [ "$REFLECTOR_ID"   == "$reflector" ]; then
      reflect $reflectargs
      break
    fi
  done
  clean_reflection
}

function clean_reflection() {
  # Reset
  reflectorName
  reflectorId
}
