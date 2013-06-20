#!/bin/bash

# Repopick enhancements
CHANGES+=(44336 44456 44457)

# Mutex protection in TKEY
CHANGES+=(37621)

# GPIO config fix in TKEY
CHANGES+=(42894)

# cpufreq: enforce governor to stay in sync across CPU cores
CHANGES+=(43536)

# Fix VOIP
CHANGES+=(44156)

# Fix compiling of media
CHANGES+=(44476)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

