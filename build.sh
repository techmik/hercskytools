#!/bin/bash

COMMAND="$1"
ADDITIONAL="$2"

# Starting timer
START=$(date +%s)

# Device specific settings
    case "$COMMAND" in
        clean)
                cd kernel/samsung/msm8660-common
                make mrproper
                cd ../../../
                make clobber
                exit
                ;;
        prepare)
                repo abandon auto
                repo sync -j8
                exit
                ;;

        skyrocket)
                ./hercskytools/cm10-${COMMAND}-apply.sh
                . build/envsetup.sh
                ./vendor/cm/get-prebuilts
                brunch cm_skyrocket-eng
                ;;
        hercules)
                ./hercskytools/cm10-${COMMAND}-apply.sh
                . build/envsetup.sh
                ./vendor/cm/get-prebuilts
                brunch cm_hercules-eng
                ;;
        *)
                echo -e "Usage: $0 DEVICE ADDITIONAL"
                echo -e "Example: ./build.sh skyrocket"
                echo -e "Supported Devices: skyrocket, hercules"
                echo -e "Use: ./build.sh clean to make clobber"
                echo -e "Use: ./build.sh prepare to repo sync"
                exit 2
                 ;;
esac

# End timer and print elapsed time
END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n " $E_SEC

