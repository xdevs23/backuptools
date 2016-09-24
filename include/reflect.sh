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


rfl_break_oo=0
rfl_nobreak_oo=1

function run() {
  run_internal $rfl_break_oo $@
}

function runall() {
  run_internal $rfl_nobreak_oo $@
}

function run_internal() {
  breakoo="$1"
  shift 1
  local reflectresult=0
  local allargs="$@"
  local reflector="$1"
  local reflectargs="${allargs//$reflector /}"
  for sc in $(find $REFLECTORS_PATH/ -type f); do
    local reflfn="${sc/$REFLECTOR_PATH\//}"
    source $sc
    local reflectresult=$?
    if [ ! $reflectresult -eq 0 ]; then
      echo -e "\033[91mReflector $reflfln is invalid or failed!\033[0m"
      break
    fi
    if [ "$REFLECTOR_NAME" == "$reflector" ] ||
       [ "$REFLECTOR_ID"   == "$reflector" ]; then
      reflect $reflectargs
      if [ $breakoo -eq $rfl_break_oo ]; then
        break
      fi
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
