#!/bin/bash

# Contact preloading
CHANGES+=(46386)

# BT kernel fixes
CHANGES+=(47212 47217)

# BT tethering, BT sleep bugs
CHANGES+=(47234 47211)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

