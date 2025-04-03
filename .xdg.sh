#!/bin/bash
export USER_BIN_HOME="${USER_CONFIG_HOME}/bin"
export USER_DEP_HOME="${USER_CONFIG_HOME}/dep"
export XDG_DATA_HOME="${USER_CONFIG_HOME}/data"
export XDG_CONFIG_HOME="${USER_CONFIG_HOME}/etc"
export XDG_CACHE_HOME="${USER_CONFIG_HOME}/cache"

mkdir -p "${USER_BIN_HOME}" >/dev/null
mkdir -p "${USER_DEP_HOME}" >/dev/null
mkdir -p "${XDG_CONFIG_HOME}" >/dev/null
mkdir -p "${XDG_DATA_HOME}" >/dev/null
mkdir -p "${XDG_CACHE_HOME}" >/dev/null


chmod -R +x $USER_BIN_HOME

export PATH="${USER_BIN_HOME}:${PATH}"
