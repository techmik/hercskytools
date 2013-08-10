#!/bin/bash

# audio/msm8660: use ALSA policy manager
CHANGES+=(47390)

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

# Add PR_{GET,SET}_NO_NEW_PRIVS to prevent execve from granting privs
CHANGES+=(47338)

# Typo fix in OMX
CHANGES+=(47297)

# Focal overlay
CHANGES+=(47432)

# msm8660: Use retire fence from MDP driver
CHANGES+=(47492)

# CPU-specific optimizations
CHANGES+=(47507)

# dynThreshold to 1.9
CHANGES+=(47516)

# LP audio
CHANGES+=(47517)

# SELinux policy
CHANGES+=(47521)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

