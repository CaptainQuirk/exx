#!/usr/bin/env bats

load "$(dirname $BATS_TEST_DIRNAME)/functions"
load "$PWD/functions.sh"


PLIST_BUDDY_PATH="/usr/libexec/"

function setup() {
    if [ ! -x "$PLIST_BUDDY_PATH/PlistBuddy" ]; then
        #stub PlistBuddy "echo 7.2"
    fi
}

@test "Read latest version " {
    [ `latest_version` == "7.2" ]
}

#teardown() {
    #remove_stubs
#}
