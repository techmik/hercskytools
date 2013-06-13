#!/bin/bash

# msm serial: bulk update from caf jb_2.5
#CHANGES+=(43791)

# roger_n's Test: Incognito
#framework: Run in Incognito Mode (WIP)
CHANGES+=(44192)

#settings: Run in Incognito Mode (WIP)
CHANGES+=(44193)

#contacts: Incognito mode support (WIP)
CHANGES+=(44194)

#telephony: Support for Incognito Mode (WIP)
CHANGES+=(44240)

#calendar: Incognito mode support
CHANGES+=(44233)


# m7-common: set amplifier configs based on audio mode
# ** needs rebase **
#CHANGES+=(38221 38256)

# m7: Make the ringtone properly repeat
CHANGES+=(43943)

# bluesleep: update from jf kernel
CHANGES+=(43687)

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

