#!/bin/bash

# Android Device common
CHANGES+=(46066 46080 46081)

# DashPlayer: make jb_mr2 compatible
CHANGES+=(46086)

# msm8960-common: add TARGET_CPU_VARIANT
CHANGES+=(46079)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}
