#!/bin/bash

# audio/msm8660 fixes
CHANGES+=(46107)

# use older ION
CHANGES+=(46106)

# gralloc (display-caf)
CHANGES+=(46166)

# DashPlayer: make jb_mr2 compatible
CHANGES+=(46086)

#Use display-caf for QCOM_BSP
CHANGES+=(46183)

#hwc: Add support for smooth streaming feature.
CHANGES+=(46205)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

