#!/bin/bash

# SELinux
CHANGES+=(45841)

# hangup and dialback from IncallScreen
CHANGES+=(44780)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}
