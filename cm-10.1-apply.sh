#!/bin/bash

# Mutex protection in TKEY
CHANGES+=(37621)

# LCD disable late resume
CHANGES+=(43804)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

