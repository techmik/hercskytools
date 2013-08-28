#!/bin/bash

# Focal overlay
CHANGES+=(47432)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

