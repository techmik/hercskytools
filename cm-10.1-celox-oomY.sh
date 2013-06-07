#!/bin/bash

# Low memory killer ANDROID_LOW_MEMORY_KILLER_AUTODETECT_OOM_ADJ_VALUES=y fix
CHANGES+="43476 "

# Do the cherry-picking
./build/tools/repopick.py $CHANGES \
    --ignore-missing \
    --start-branch auto \
    --abandon-first \

