#!/bin/bash

# Auto brightness
CHANGES+=(46609 46610)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

