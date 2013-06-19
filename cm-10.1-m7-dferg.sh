#!/bin/bash

# Repopick enhancements
CHANGES+=(44336 44456 44457)

# amp init sequence
CHANGES+=(44392 38221 38256)

# use CAF media variant
CHANGES+=(44447)

# bluesleep from tegra
CHANGES+=(44423 44424 44425 44426 44427 44428 44429 44430 44431 44432 44433 44434)

# Incognito Mode (WIP)
CHANGES+=(44192 44193 44194 44240 44233)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

