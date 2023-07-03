#!/usr/bin/bash

export DVIM_RUNTIME_DIR="${DVIM_RUNTIME_DIR:-"$HOME/.local/share/domacsvim"}"
export DVIM_CONFIG_DIR="${DVIM_CONFIG_DIR:-"$HOME/.config/dvim"}"
export DVIM_CACHE_DIR="${DVIM_CACHE_DIR:-"$HOME/.cache/dvim"}"

nvim -u ${DVIM_RUNTIME_DIR}/init.lua "$@"
