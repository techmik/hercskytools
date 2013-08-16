#!/bin/bash

# msm8660: enable Qualcomm AV enhancements
CHANGES+=(46624)

# msm8660: support Samsung extended AGPS
CHANGES+=(46629)

# Add PR_{GET,SET}_NO_NEW_PRIVS 
CHNAGES+=(47338)

# Focal overlay
CHANGES+=(47432)

# remove journal_async_commit in fstab
CHANGES+=(47856)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

