#!/usr/bin/env bash

# checks if commands and utilities are installed on computer
# ${1}  command
# returns 0 for success. Otherwise, failure
is_installed() {
  type "${1}" > /dev/null 2>&1
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

