#!/bin/bash

# audio/msm8660 fixes
CHANGES+=(46107)

# use older ION
CHANGES+=(46106)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

