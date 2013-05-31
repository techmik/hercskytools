#!/bin/bash

# 4.4.3 toolchain
#CHANGES+="37948 "

# Forward port of TKEY
#CHANGES+="42895 "

# LCD brightness
CHANGES+="43367 "

# Do the cherry-picking
BRANCH_NAME="auto"
`dirname $0`/repopick.py $CHANGES \
    --ignore-missing \
    --start-branch $BRANCH_NAME \
    --abandon-first \

