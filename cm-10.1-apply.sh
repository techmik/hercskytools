#!/bin/bash

# Forward port of TKEY
#CHANGES+="42895 "

# LCD code cleanup
CHANGES+="43673 "

# LCD reset enabled
CHANGES+="43679 "

# Do the cherry-picking
BRANCH_NAME="auto"
`dirname $0`/repopick.py $CHANGES \
    --ignore-missing \
    --start-branch $BRANCH_NAME \
    --abandon-first \

