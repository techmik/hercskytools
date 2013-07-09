#!/bin/bash

# Kernel cleanups
# - cifs: use offsetof macro
CHANGES+=(45312)
# - clean up uninitialized variables
CHANGES+=(45313)
# - fix Kconfig error for INPUT_YAS529_POSITION
CHANGES+=(45314)
# - build optimizations for gcc4.6
CHANGES+=(45324)

# Misc cleanups
# - libpng: fix compiler warnings
CHANGES+=(44845)

# CCACHE_BASEDIR override
CHANGES+=(44949)

# Radio version check
CHANGES+=(44984 44983 45029)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

