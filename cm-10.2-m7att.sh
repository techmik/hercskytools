#!/bin/bash

# Android Device common
CHANGES+=(46066 46080 46081)

#DashPlayer: make jb_mr2 compatible
CHANGES+=(46086)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}
