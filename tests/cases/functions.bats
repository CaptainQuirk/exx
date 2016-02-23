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

@test "get_latest_version_path returns a valid path" {
    load "$(dirname $BATS_TEST_DIRNAME)/mocks/PlistBuddy"
    path=$(get_latest_version_path)

    [ "$path" == "/Applications/Xcode.app/Contents/version.plist" ]
    [ "$?" == 0 ]
}

@test "get_latest_version function prints the output of PlistBuddy" {
    # Load PlistBuddy mock
    load "$(dirname $BATS_TEST_DIRNAME)/mocks/PlistBuddy"
    version=$(get_latest_version)

    # Check that number is 7.2 and that the function returned 0
    [ "$version" == "7.2" ]
    [ "$?" == 0 ]
}
