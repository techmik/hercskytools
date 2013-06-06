#!/bin/bash

# Noobl RIL
CHANGES+="43476 "

# Do the cherry-picking
./build/tools/repopick.py $CHANGES \
    --ignore-missing \
    --start-branch auto \
    --abandon-first \

