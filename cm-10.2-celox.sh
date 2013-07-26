#!/bin/bash

# use caf media variant
CHANGES+=(46059)

# NativeNfcManager: fix build
CHANGES+=(46040)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

