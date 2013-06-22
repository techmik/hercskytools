#!/bin/bash

# Repopick enhancements
CHANGES+=(44336 44456 44457)

# amp init sequence
#CHANGES+=(44392 38221 38256)

# Incognito Mode (WIP)
CHANGES+=(44192 44193 44194 44240 44233)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

