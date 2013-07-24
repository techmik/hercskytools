#!/bin/bash

# Touchkey Driver
# - backlight notification
CHANGES+=(45646 45648)

# CCACHE_BASEDIR override
CHANGES+=(44949)

# Radio version check - Hercules
CHANGES+=(44983)

# SELinux
CHANGES+=(45527)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

