#!/bin/bash

function include() {
  for i in $@; do
    source $TOP/include/$i.sh
  done
}

function declaredynamic() {
  declare $1=$2
}

function getdynamic() {
  varname="$1"
  echo -n ${!varname}
}
include reflect
include colors
include precheck
include product_config

doprecheck
if [ ! $? -eq 0 ]; then
  exit $?
fi
