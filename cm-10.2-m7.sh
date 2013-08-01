#!/bin/bash

# Auto brightness
CHANGES+=(46609 46610)

# Contact preloading
CHANGES+=(46386)

# Audio kernel update
CHANGES+=(46742)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

