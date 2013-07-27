#!/bin/bash

# audio/msm8660 fixes
CHANGES+=(46107)

# use older ION
CHANGES+=(46106)

# gralloc (display-caf)
CHANGED+=(46166)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

