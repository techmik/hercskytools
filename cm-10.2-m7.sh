#!/bin/bash

# Set network attributes
CHANGES+=(47386)

# IR HAL
CHANGES+=(47283)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

