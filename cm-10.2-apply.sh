#!/bin/bash

# TARGET_CPU_VARIANT
CHANGES+=(46053)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

