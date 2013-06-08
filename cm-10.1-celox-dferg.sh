#!/bin/bash

# Mutex protection in TKEY
CHANGES+=(37621)

# GPIO config fix in TKEY
CHANGES+=(42894)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

