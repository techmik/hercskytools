#!/bin/bash

# Forward port of TKEY
#CHANGES+="42895 "

# Mutex protection in TKEY
CHANGES+="37621 "

# LCD code cleanup
#CHANGES+="43673 "

# LCD backlight/brightness lock
#CHANGES+="43732 "

# LDC debugging code
#CHANGES+="43793 "

# LCD disable late resume
CHANGES+="43804 "

# Do the cherry-picking
BRANCH_NAME="auto"
`dirname $0`/repopick.py $CHANGES \
    --ignore-missing \
    --start-branch $BRANCH_NAME \
    --abandon-first \

