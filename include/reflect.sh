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

function log() {
  logd "[reflect] $@"
}

rfl_break_oo=0
rfl_nobreak_oo=1

function run() {
  log "Called for reflect run"
  run_internal $rfl_break_oo $@
}

function runall() {
  log "Called for reflect runall"
  run_internal $rfl_nobreak_oo $@
}

function run_internal() {
  log "Internal reflect run reached"
  breakoo="$1"
  shift 1
  local reflectresult=0
  local allargs="$@"
  local reflector="$1"
  local reflectargs="${allargs//$reflector /}"
  log "Requested reflector: $reflector"
  for sc in $(find $REFLECTORS_PATH/ -type f); do
    local reflfn="${sc/$REFLECTOR_PATH\//}"
    log "Found reflector $reflfn"
    source $sc
    log "Checking reflector"
    local reflectresult=$?
    if [ ! $reflectresult -eq 0 ]; then
      echo -e "\033[91mReflector $reflfln is invalid or failed!\033[0m"
      break
    fi
    if [ "$REFLECTOR_NAME" == "$reflector" ] ||
       [ "$REFLECTOR_ID"   == "$reflector" ]; then
      log " => Reflecting!"
      reflect $reflectargs
      reflectresult=$?
      if [ $breakoo -eq $rfl_break_oo ]; then
        log " => Reflection of $reflfn finished"
        break
      fi
    fi
  done
  clean_reflection
  log "Reflection result: $reflectresult"
  return $reflectresult
}

function clean_reflection() {
  # Reset
  reflectorName
  reflectorId
}
