#!/bin/bash

# Mutex protection in TKEY
CHANGES+=(37621)

# GPIO config fix in TKEY
CHANGES+=(42894)

# LCD disable late resume
#CHANGES+=(43804)

# ld9040: fix late resume
CHANGES+=(43984)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

