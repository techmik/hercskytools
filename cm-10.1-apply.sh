#!/bin/bash

# Repopick enhancements
CHANGES+=(44336 44456 44457)

# Mutex protection in TKEY
CHANGES+=(37621)

# GPIO config fix in TKEY
CHANGES+=(42894)

# cpufreq: enforce governor to stay in sync across CPU cores
CHANGES+=(43536)

# Voip fixes for Samsung
CHANGES+=(44738 44741 44962 44963 44964 44880 44981)

# Changes for GCC 4.6
CHANGES+=(44849 44728 44845)

# Kconfig fix
CHANGES+=(44979)

# CCACHE_BASEDIR override
CHANGES+=(44949)

# Radio version check
CHANGES+=(44985 44984 44983)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

