#!/bin/bash

# Repopick enhancements
CHANGES+=(44336 44456 44457)

# amp init sequence
#CHANGES+=(44392 38221 38256)

# BT
CHANGES+=(44785)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

