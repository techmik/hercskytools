#!/bin/bash

# Changes for GCC 4.6
# - use 4.6 instead of 4.4.3
CHANGES+=(44849)
# - code clean ups
CHANGES+=(44728)
# - libpng: fix compiler warnings
CHANGES+=(44845)

# CCACHE_BASEDIR override
CHANGES+=(44949)

# Radio version check
CHANGES+=(44984 44983 45029)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

