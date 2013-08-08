#!/bin/bash

# audio/msm8660 fixes
CHANGES+=(46107)
CHANGES+=(47114)
CHANGES+=(47202)
CHANGES+=(47210)
CHANGES+=(47231)

# gralloc (display-caf)
CHANGES+=(46166)

# libgralloc:  Change ionFlags for GRALLOC_USAGE_PRIVATE_MM_HEAP case
#   - fixes secure memory crash in OMX
CHANGES+=(46521)

# DashPlayer: make jb_mr2 compatible
CHANGES+=(46086)

# Use display-caf for QCOM_BSP
#CHANGES+=(46183)

# libstagefright: Add legacy LPAPlayer
CHANGES+=(46451)

# msm8660: enable Qualcomm AV enhancements
CHANGES+=(46624)

# msm8660: move Camera overlay and update
CHANGES+=(46625)

# msm8660: support Samsung extended AGPS
CHANGES+=(46629)

# Camera: Bring Samsung camera fixes and features to 4.3
CHANGES+=(46287)

# TunnelAudio: Fixes playback with Qualcomm tunnel audio for players which use gapless api
CHANGES+=(46607)


# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

