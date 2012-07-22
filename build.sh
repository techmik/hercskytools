#!/bin/bash

COMMAND="$1"
ADDITIONAL="$2"

case `uname -s` in
    Darwin)
        txtrst='\033[0m'  # Color off
        txtred='\033[0;31m' # Red
        ;;
    *)
        txtrst='\e[0m'  # Color off
        txtred='\e[0;31m' # Red
        ;;
esac

# Starting timer
START=$(date +%s)

# Device specific settings
    case "$COMMAND" in
        clean)
                make clobber
                exit
                ;;
        prepare)
               repo sync -j8
                ./hercskytools/cm10-${COMMAND}-apply.sh
                exit
                ;;

        skyrocket)
                . build/envsetup.sh
                ./vendor/cm/get-prebuilts
                brunch cm_skyrocket-eng
                exit
                ;;
        hercules)
                . build/envsetup.sh
                ./vendor/cm/get-prebuilts
                brunch cm_hercules-eng
                exit
                ;;
        *)
                echo -e "${txtred}$Usage: $0 DEVICE ADDITIONAL"
                echo -e "Example: ./build.sh skyrocket"
                echo -e "Supported Devices: skyrocket, hercules"
                exit 2
                 ;;
esac

# End timer and print elapsed time
END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "${txtred}Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n ${txtred}" $E_SEC

