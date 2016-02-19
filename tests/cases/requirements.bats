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
    # Stub bash "type" built-in with a condition to return
    # false only if argument is PlistBuddy
    return_false="$(return_false_if 'PlistBuddy')"
    stub type "$return_false"

    run exx
    [ "$status" -eq 1 ]
    [ "$output" = "exx: PlistBuddy command is not available. Is /usr/bin/libexec in you PATH ?" ]
}

teardown() {
    clear_stubs
}
