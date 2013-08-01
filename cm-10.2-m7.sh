#!/bin/bash

# Auto brightness
CHANGES+=(46609 46610)

# Contact preloading
CHANGES+=(46386)

# Blacklist
CHANGES+=(46382 46356 46359 46353 46354)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

