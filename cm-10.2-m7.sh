#!/bin/bash

# BT kernel fixes
#CHANGES+=(47212 47217)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

