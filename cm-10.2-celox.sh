#!/bin/bash

# Determine which device we're applying patches for
PARAM=`echo $1 | cut -d '-' -f 1`

#####
#####  THIS SECTION IS FOR COMMITS THAT APPLY TO ALL DEVICES
#####		Skyrocket, Hercules & Exhilarate
#####

# Focal overlay
CHANGES+=(47432)

#####
#####   END GENERAL PICK SECTION
#####

# Insert device specific picks in the appropriate location below

case $PARAM in
	skyrocket)
		# PLACE SKYROCKET SPECIFIC PICKS HERE

	;;
	hercules)
		# PLACE HERCULES SPECIFIC PICKS HERE

	;;
	exhilarate)
		# PLACE EXHILARATE SPECIFIC PICKS HERE

	;;
esac

# Do the cherry-picking
./build/tools/repopick.py -b ${CHANGES[@]}

