#!/bin/bash

# audio/msm8660 fixes
CHANGES+=(46107)

# use older ION
CHANGES+=(46106)

# use other include
CHANGES+=(46183)

# gralloc (display-caf)
CHANGES+=(46166)

# DashPlayer: make jb_mr2 compatible
CHANGES+=(46086)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

