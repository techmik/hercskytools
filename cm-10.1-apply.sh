#!/bin/bash

# Touchkey Driver
# - backlight notification
CHANGES+=(45347)

# Misc cleanups
# - libpng: fix compiler warnings
CHANGES+=(44845)

# CCACHE_BASEDIR override
CHANGES+=(44949)

# Radio version check - Hercules
CHANGES+=(44983)

# SELinux
CHANGES+=(45527 45479)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

