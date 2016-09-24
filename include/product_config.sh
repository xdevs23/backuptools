#!/bin/bash

export PRODUCT_NAME=""
export PRODUCT_VERSION=""
export PRODUCT_CMD_DEPS="bash cat pwd source"
       MAIN_ENTRY_POINT_CFG="$TOP/script/entrypoint"
if [ -f "$MAIN_ENTRY_POINT_CFG" ]; then
  export MAIN_ENTRY_POINT="$(cat $TOP/script/entrypoint)"
else
  export MAIN_ENTRY_POINT="script/main.sh"
fi
export PRODUCT_SPEC_CONFIGURE=""
# Enabled logd usually also means enabled debugging mode.
# Hence we enable examples by default if logd is enabled.
# Can be enabled/disabled using product config explicitly.
export PRODUCT_DISABLE_EXAMPLES="1"
[ "$XDBFW_LOGD_ENABLED" == "1" ] && \
  export PRODUCT_DISABLE_EXAMPLES="0" &&
  logd "[Product config] Examples enabled by default because logd is active."

function ProductName() {
  export PRODUCT_NAME="$@"
}

function ProductVersion() {
  export PRODUCT_VERSION="$@"
}

function ProductCmdDeps() {
  export PRODUCT_CMD_DEPS="$PRODUCT_CMD_DEPS $@"
}

function MainEntryPoint() {
  export MAIN_ENTRY_POINT="$@"
}

function ProductConfigure() {
  export PRODUCT_SPEC_CONFIGURE="$@"
}

function DisableExamples() {
  export PRODUCT_DISABLE_EXAMPLES="1"
}

function EnableExamples() {
  export PRODUCT_DISABLE_EXAMPLES="0"
}
