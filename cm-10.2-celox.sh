#!/bin/bash

# audio/msm8660 fixes
CHANGES+=(46107)

# use older ION
CHANGES+=(46106)

# NativeNfcManager: fix build
CHANGES+=(46040)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

