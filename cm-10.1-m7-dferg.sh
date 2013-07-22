#!/bin/bash

# SELinux
CHANGES+=(45841)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

