#!/bin/bash

# Forward port of TKEY
#CHANGES+="42895 "

# LCD code cleanup
#CHANGES+="43673 "

# LCD reset enabled
#CHANGES+="43679 "

# Mutex protection in TKEY
CHANGES+="37621 "

# GPIO config fix in TKEY
CHANGES+="42894 "

# Locking clean up in lcdc
CHANGES+="43547 "

# Noobl RIL
CHANGES+="43476 "

# Do the cherry-picking
./build/tools/repopick.py $CHANGES \
    --ignore-missing \
    --start-branch auto \
    --abandon-first \

