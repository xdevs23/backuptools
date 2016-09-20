#!/bin/bash

# THIS IS NOT PART OF THE REFLECTION EXAMPLE
cd ../
TOP="$(pwd)"
source include/basic.sh

function run() {
  # Stub!
  # This is not supposed to be an include
  return 1
}

# START OF REFLECTION EXAMPLE

include reflect

run Example
