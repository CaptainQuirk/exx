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
    export TMP_BATS_PLIST_BUDDY_VERSION="7.2"
    expected="7.2
7.1
6.4
6.1
5.1"

    run exx ls

    log "$output"

    [ "$status" -eq 1 ]
    [ "$output" == "$expected" ]
}

