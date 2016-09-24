#!/bin/bash

export INCLUDE_BASIC_SH="1"

function include() {
  for i in $@; do
    source $TOP/include/$i.sh
  done
}

# Thanks http://mivok.net/2009/09/20/bashfunctionoverrist.html
function save_function() {
    local ORIG_FUNC=$(declare -f $1)
    local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
    eval "$NEWNAME_FUNC"
}

function declaredynamic() {
  varname="$1"
  shift
  varvalue="$@"
  export $varname="$varvalue"
}

function getdynamic() {
  varname="$1"
  echo -n ${!varname}
}

function markAsExample() {
  declaredynamic REFL_${REFLECTOR_ID}_ISEXAMPLE 1
}

function isReflectorExample() {
  [ "$(getdynamic REFL_${REFLECTOR_ID}_ISEXAMPLE)" == "1" ] && \
  [ "$PRODUCT_DISABLE_EXAMPLES" == "1" ]
}

function cmdHelpText() {
  isReflectorExample && return 0
  local tcommand="$(getdynamic COMMAND_${REFLECTOR_ID}_ASSOC_CMD)"
  local command="${tcommand/-/___DASH___}"
  if [ ! -z "$(getdynamic COMMAND_${command}_HAS_HELP)" ]; then
    return 0
  fi
  declaredynamic COMMAND_${command}_HAS_HELP 1
  export MAIN_COMMANDS_HELP="$MAIN_COMMANDS_HELP$tcommand  \t$@\n"
}

function associateCmd() {
  isReflectorExample && return 0
  local tcommand="$1"
  local command="${tcommand/-/___DASH___}"
  declaredynamic COMMAND_${command}_RUNPOINT $REFLECTOR_ID
  declaredynamic COMMAND_${REFLECTOR_ID}_ASSOC_CMD $tcommand
}

function getReflectorForCmd() {
  local command="$1"
  local command="${command/-/___DASH___}"
  local refl="$(getdynamic COMMAND_${command}_RUNPOINT)"
  echo -n $refl
}

logfifoname="xdbfw_log_d.pipe"
[ "$XDBFW_LOGD_ENABLED" == "1" ] && mkfifo /tmp/$logfifoname 2>/dev/null || true

function logd() {
  [ "$XDBFW_LOGD_ENABLED" == "1" ] && echo "$@">/tmp/$logfifoname || true
}

function logt() {
  logd "[$REFLECTOR_NAME] $@"
}

logd "Welcome."

include reflect
include colors
include precheck
include product_config

export MAIN_COMMANDS_HELP=""

doprecheck
if [ ! $? -eq 0 ]; then
  exit $?
fi
