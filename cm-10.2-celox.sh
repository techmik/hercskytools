#!/bin/bash

# msm8660: enable Qualcomm AV enhancements
CHANGES+=(46624)

# msm8660: move Camera overlay and update
CHANGES+=(46625)

# msm8660: support Samsung extended AGPS
CHANGES+=(46629)

# Camera: Bring Samsung camera fixes and features to 4.3
CHANGES+=(46287)

# Add PR_{GET,SET}_NO_NEW_PRIVS to prevent execve from granting privs
#CHANGES+=(47338)

# Focal overlay
CHANGES+=(47432)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

