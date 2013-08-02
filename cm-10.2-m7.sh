#!/bin/bash

# BT audio fix
CHANGES+=(46777 46768)

# Auto brightness
CHANGES+=(46609 46610)

# Contact preloading
CHANGES+=(46386)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

