#!/bin/bash

# msm serial: bulk update from caf jb_2.5
CHANGES+=(43791)

# bluesleep: update from jf kernel
CHANGES+=(43687)

# m7-common: set amplifier configs based on audio mode
CHANGES+=(38221 38256)

# m7: Make the ringtone properly repeat
CHANGES+=(43943)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

