#!/bin/bash

function doprecheck() {
  logd "Running pre-check..."
  runall reflect_rt_precheck
}
