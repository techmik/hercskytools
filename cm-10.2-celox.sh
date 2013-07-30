#!/bin/bash

# audio/msm8660 fixes
CHANGES+=(46107)

# gralloc (display-caf)
CHANGES+=(46166)

# DashPlayer: make jb_mr2 compatible
CHANGES+=(46086)

# Use display-caf for QCOM_BSP
CHANGES+=(46183)

# gralloc: Add workaround for Jellybean camera drivers
CHANGES+=(46310)

# mm-video: revert usage of flag GRALLOC_USAGE_PRIVATE_CP_BUFFER
CHANGES+=(46276)

# libstagefright: Add legacy LPAPlayer
CHANGES+=(46451)

# msm8660: use legacy alsa audio
CHANGES+=(46450)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

