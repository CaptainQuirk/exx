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

    log "test : $(echo $(fgc green "7.2")$(fgc end))"

    expected="  $(echo $(fgc green "7.2")$(fgc end))
  7.1
  6.4
  6.1
  5.1"
    log "expected : $expected"
    #log "last return : $?"

    run exx ls

    log "status : $status"
    log "output : $output"
    [ "$status" -eq 0 ]
    [ "$output" == "$expected" ]
}

