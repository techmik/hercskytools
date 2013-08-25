#!/bin/bash

# Focal overlay
CHANGES+=(47432)

# repopick: fix broken pipe error from "repo list"
CHANGES+=(48501)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

