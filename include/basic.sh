#!/bin/bash

function include() {
  for i in $@; do
    source $TOP/include/$i.sh
  done
}

include reflect
include colors
include precheck
include product_config

doprecheck
if [ ! $? -eq 0 ]; then
  exit $?
fi
