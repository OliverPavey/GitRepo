#!/usr/bin/env bash

if [[ "$OSTYPE" == "msys" ]]; then
    GITREPO_BINARY=./bin/windows/amd64/gitrepo.exe
else
    GITREPO_BINARY=./bin/linux/amd64/gitrepo
fi

EXPECTED_GITSSH='git@github.com:OliverPavey/GitRepo.git'
EXPECTED_GITHTTPS=https://github.com/OliverPavey/GitRepo.git
EXPECTED_WEBPAGE=https://github.com/OliverPavey/GitRepo
EXPECTED_INFO="GitSSH  : $EXPECTED_GITSSH
GitHTTPS: $EXPECTED_GITHTTPS
WebPage : $EXPECTED_WEBPAGE"

FAILURES=0

runtest() {
    COMMAND=$1
    EXPECTED=$2
    ACTUAL=$($GITREPO_BINARY $COMMAND)
    if [[ $EXPECTED == $ACTUAL ]]; then
        echo "PASS: gitrepo $COMMAND = '$EXPECTED'"
    else
        echo "FAIL: gitrepo $COMMAND = '$ACTUAL' but should be '$EXPECTED'"
        FAILURES=$(($FAILURES + 1))
    fi
}

runtest 's' $EXPECTED_GITSSH
runtest 'ssh' $EXPECTED_GITSSH
runtest 'h' $EXPECTED_GITHTTPS
runtest 'https' $EXPECTED_GITHTTPS
runtest 'w' $EXPECTED_WEBPAGE
runtest 'web' $EXPECTED_WEBPAGE
runtest 'i' "$EXPECTED_INFO"
runtest 'info' "$EXPECTED_INFO"

if [[ $FAILURES == 0 ]]; then
    echo 'ALL PASSED.'
else
    echo "$FAILURES TESTS FAILED."
    exit 1
fi
