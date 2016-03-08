#!/usr/bin/env bats

# Loading test helper functions and main utilities
# functions
load "$(dirname $BATS_TEST_DIRNAME)/functions"
load "$PWD/functions.sh"

setup() {
    export PATH="$PWD/bin:$PATH"
    export PATH="$PWD/tests/mocks:$PATH"
}

teardown() {
    clear_stubs
}

@test "ls subcommand returns the latest version and the others installed" {
    value_stub=$(echo_value "7.2")
    stub PlistBuddy "$value_stub"

    expected="7.2
7.1
6.4
6.1
5.1"

    run exx ls

    [ "$status" -eq 0 ]
    [ "$output" == "$expected" ]
}

