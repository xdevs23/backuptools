#!/bin/bash

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
  declare $1=$2
}

function getdynamic() {
  varname="$1"
  echo -n ${!varname}
}

logfifoname="xdbfw_log_d.pipe"
mkfifo /tmp/$logfifoname 2>/dev/null || true

function logd() {
  [ "$XDBFW_LOGD_ENABLED" == "1" ] && echo "$@">/tmp/$logfifoname
}

function logt() {
  logd "[$REFLECTOR_NAME] $@"
}

logd "logd available!"

include reflect
include colors
include precheck
include product_config

doprecheck
if [ ! $? -eq 0 ]; then
  exit $?
fi
