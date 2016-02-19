#!/usr/bin/env bats

# Loading test helper functions and main utilities
# functions
load "$(dirname $BATS_TEST_DIRNAME)/functions"
load "$PWD/functions.sh"

setup() {
    export PATH="$PWD/bin:$PATH"
}

@test "exx fails if xcode-select is missing" {
    # Stub bash "type" built-in
    return_false="$(return_false)"
    stub type "$return_false"

    run exx
    [ "$status" -eq 1 ]
    [ "$output" = "exx: xcode-select command is not installed" ]
}

@test "exx fails if PlistBuddy is missing" {
    stub xcode-select ""
    if ! is_installed "PlistBuddy" ; then
        run exx
        echo $output
        [ "$status" -eq 1 ]
        [ "$output" = "exx: PlistBuddy command is not available. Is /usr/bin/libexec in you PATH ?" ]
    fi
}

teardown() {
    clear_stubs
}
