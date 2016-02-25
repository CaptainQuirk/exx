#!/usr/bin/env bats

# Loading test helper functions and main utilities
# functions
load "$(dirname $BATS_TEST_DIRNAME)/functions"
load "$PWD/functions.sh"

setup() {
    export PATH="$PWD/bin:$PATH"
    export PATH="$PWD/tests/mocks:$PATH"
}

@test "is_installed function returns 1 if program is not installed" {
    # Stub bash "type" built-in
    return_false="$(return_false)"
    stub type "$return_false"

    ! is_installed "xcode-select"
}

@test "is_installed function returns 0 if program is installed"  {
    # Stub bash "type" built-in with a condition to return
    # false only if argument is PlistBuddy
    return_false="$(return_false_if 'PlistBuddy')"
    stub type "$return_false"

    is_installed "xcode-select"
}

# get_latest_version_path
# -----------------------

@test "get_latest_version_path returns a valid path" {
    path=$(get_latest_version_path)

    [ "$path" == "/Applications/Xcode.app/Contents/version.plist" ]
    [ "$?" == 0 ]
}


# get_plist_path
# --------------

@test "get_plist_path returns the valid path to a plist file" {
    xcode_select_path="/Applications/Xcode.app/Contents/Developer"
    plist_path=$(get_plist_path $xcode_select_path)

    [ "$plist_path" == "/Applications/Xcode.app/Contents/version.plist" ]
    [ "$?" == 0 ]
}


# current_version_path
# --------------------

@test "current_version_path finds the correct path if the current version is the latest" {
    load "$(dirname $BATS_TEST_DIRNAME)/mocks/xcode-select"
    export TMP_BATS_XCODE_SELECT_PATH="/Applications/Xcode.app/Contents/Developer"

    current_path=$(get_current_version_path)
    [ "$current_path" == "/Applications/Xcode.app/Contents/version.plist" ]
    [ "$?" == 0 ]
}

@test "current_version_path finds the correct path if the current version a former one" {
    load "$(dirname $BATS_TEST_DIRNAME)/mocks/xcode-select"
    export TMP_BATS_XCODE_SELECT_PATH="/Applications/Xcode/6.4/Xcode.app/Contents/Developer"

    current_path=$(get_current_version_path)
    [ "$current_path" == "/Applications/Xcode/6.4/Xcode.app/Contents/version.plist" ]
    [ "$?" == 0 ]
}


# get_version_options
# -------------------

@test "get_version_options returns a list of valid options" {
    options=$(get_version_options)

    [ "$options" == "-c \"Print CFBundleShortVersionString\"" ]
    [ "$?" == 0 ]
}


# get_version
# -----------

@test "get_version returns the correct version from plist file" {

}


# get_latest_version
# ------------------

@test "get_latest_version function prints the output of PlistBuddy" {
    # Load PlistBuddy mock
    export TMP_BATS_PLIST_BUDDY_VERSION="7.2"
    load "$(dirname $BATS_TEST_DIRNAME)/mocks/PlistBuddy"

    version=$(get_latest_version)

    # Check that number is 7.2 and that the function returned 0
    [ "$version" == "7.2" ]
    [ "$?" == 0 ]
}
