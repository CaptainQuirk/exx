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
    local command="xcode-select -p | cut -d\/ -f $field"

    local current_dir_name=$(command)

    if [ "$current_dir_name" == "Contents" ]; then
        echo "$(get_latest_version)"
        return 0
    fi

}

latest_version() {
    echo `PlistBuddy /Applications/Xcode.app/Contents/version.plist -c "Print CFBundleShortVersionString"`
}

current_version() {
    CURRENT=`xcode-select -p | cut -d\/ -f 4`
    if [ "$CURRENT" == "Contents" ]; then
        VERSIONS=("$CHECK $LATEST_VERSION \n")
        CURRENT=`/usr/libexec/PlistBuddy /Applications/Xcode.app/Contents/version.plist -c "Print CFBundleShortVersionString"`
    fi

    echo $CURRENT
}

