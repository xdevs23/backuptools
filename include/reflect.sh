#!/bin/bash

        REFLECTORS_PATH="$TOP/include/reflectors"
CURRENT_REFLECTORS_PATH="$REFLECTORS_PATH"

export REFLECTOR_NAME=""
export REFLECTOR_ID=""

function reflectorName() {
  export REFLECTOR_NAME="$@"
}

function reflectorId() {
  export REFLECTOR_ID="$1"
}

function log() {
  logd "[reflect] $@"
}

function logv() {
  [ "$XDBFW_VERBOSE_LOG" == "1" ] && \
    log "$@"
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
  local breakoo="$1"
  shift 1
  local reflectresult=0
  local allargs="$@"
  local reflector="$1"
  shift 1
  local reflectargs="$@"
  for sc in $(find $CURRENT_REFLECTORS_PATH/ -type f); do
    local reflfn="${sc/$REFLECTOR_PATH\//}"
    if [[ "$reflfn" == *".pointer" ]]; then
      local point="$(cat $sc)"
      logv "Found pointer to '$point', from '$reflfn'"
      CURRENT_REFLECTORS_PATH="$TOP/$point"
      run_internal $breakoo $allargs
      CURRENT_REFLECTORS_PATH="$REFLECTORS_PATH"
      continue
    fi
    logv "Found reflector $reflfn"
    source $sc
    local reflectresult=$?
    if [ ! $reflectresult -eq 0 ]; then
      echo -e "\033[91mReflector $reflfln is invalid or failed!\033[0m"
      break
    fi
    if isReflectorExample; then
      continue
    fi
    if [ "$REFLECTOR_NAME" == "$reflector" ] ||
       [ "$REFLECTOR_ID"   == "$reflector" ]; then
      log " => Reflecting!"
      reflect $reflectargs
      reflectresult=$?
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
  logv "Cleaning up..."
  reflectorName
  reflectorId
  unset reflect
}
