#!/bin/bash

# Mutex protection in TKEY
CHANGES+="37621 "

# LCD disable late resume
CHANGES+="43804 "

# Do the cherry-picking
BRANCH_NAME="auto"
`dirname $0`/repopick.py $CHANGES \
    --ignore-missing \
    --start-branch $BRANCH_NAME \
    --abandon-first \

