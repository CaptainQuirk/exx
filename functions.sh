#!/bin/bash

log() {
  local str="$1"
  echo "$1" >> ./tmp
}

# checks if commands and utilities are installed on computer
# ${1}  command
# returns 0 for success. Otherwise, failure
is_installed() {
  env type "${1}"
  rtn=$?

  return $rtn
}
