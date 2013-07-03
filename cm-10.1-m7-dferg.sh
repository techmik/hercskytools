#!/bin/bash

# Repopick enhancements
CHANGES+=(44336 44456 44457)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

