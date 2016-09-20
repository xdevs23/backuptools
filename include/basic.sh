#!/bin/bash

function include() {
  for i in $@; do
    source $TOP/include/$i.sh
  done
}

include colors
