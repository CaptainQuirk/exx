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

get_latest_version_path() {
    echo "/Applications/Xcode.app/Contents/version.plist"

    return 0
}

build_latest_version_args() {
    latest_version_path=$(get_latest_version_path)
    t="$latest_version_path -c \"Print CFBundleShortVersionString\""
    log "command content : $t"

    echo "$t"

    return 0
}

# get latest installed version number through PlistBuddy
# Outputs Version number on stdout
get_latest_version() {
    local version=$(PlistBuddy /Applications/Xcode.app/Contents/version.plist -c "Print CFBundleShortVersionString")
    echo $version

    return 0
}
