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

get_plist_path() {
    local xcode_select_path=$1
    local new_path="$(echo $xcode_select_path | sed 's/Developer//g')version.plist"

    echo $new_path

    return 0
}

get_current_version_path() {
    local xcode_select_path=$(xcode-select -p)
    local current_version_path=$(get_plist_path $xcode_select_path)

    echo "$current_version_path"

    return 0
}

get_version_options() {
    local options="-c \"Print CFBundleShortVersionString\""

    echo "$options"

    return 0
}

get_version() {
    local path=$1
    local options=$(get_version_options)
    local command="PlistBuddy $path $options"

    echo "$($command)"
    return 0
}

# get latest installed version number through PlistBuddy
# Outputs Version number on stdout
get_latest_version() {
    local path=$(get_latest_version_path)
    local version=$(get_version $path)
    echo $version

    return 0
}

get_current_version() {
    local field=4
    local path=$(get_current_version_path)
    local current_dir_name=$(echo $path | cut -d\/ -f $field)

    if [ "$current_dir_name" == "Contents" ]; then
        echo "$(get_latest_version)"

        return 0
    fi

    echo $(get_version $path)

    return 0
}

get_installed_versions() {
  local versions=$(find /Applications/Xcode -maxdepth 4 -name 'version.plist' -print0 | xargs -0 -n1 dirname | sort --unique --reverse | cut -d"/" -f 4)

  echo "$versions"

  return 0
}
