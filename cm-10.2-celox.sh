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

#KERNEL CHANGES
#   msm: vidc: Reset stop_called state when START is called
CHANGES+=(46206)
#   msm: vidc: set EOS on output buffer pending transaction
CHANGES+=(46207)
#   idc: Fix EOS handling if video h/w has a frame in transaction
CHANGES+=(46208)
#   msm: vidc: add support for the bitstream_restrict flag
CHANGES+=(46209)

# mm-video: revert usage of flag GRALLOC_USAGE_PRIVATE_CP_BUFFER
CHANGES+=(46276)

# mm-video: remove unneeded code from merge
CHANGES+=(46277)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

