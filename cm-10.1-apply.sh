#!/bin/bash

# Misc cleanups
# - libpng: fix compiler warnings
CHANGES+=(44845)

# CCACHE_BASEDIR override
CHANGES+=(44949)

# Radio version check - Hercules
CHANGES+=(44983)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

