#!/bin/bash

# Repopick enhancements
CHANGES+=(44336 44456 44457)

# BT
#  - breaks compiles at the moment
#CHANGES+=(44785)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

