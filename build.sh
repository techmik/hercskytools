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
                ./hercskytools/cm10.1-apply.sh
                . build/envsetup.sh
                ./vendor/cm/get-prebuilts
		if [ "$ADDITIONAL" -eq "eng" ]
		then
    			brunch cm_skyrocket-eng
		
		elif [ "$ADDITIONAL" -eq "userdebug" ]
		then
    			brunch cm_skyrocket-userdebug
		
		else
    			brunch cm_skyrocket-userdebug
		fi
                ;;
        hercules)
                ./hercskytools/cm10.1-apply.sh
                . build/envsetup.sh
                ./vendor/cm/get-prebuilts
                if [ "$ADDITIONAL" -eq "eng" ]
                then
                        brunch cm_hercules-eng
                
                elif [ "$ADDITIONAL" -eq "userdebug" ]
		then
                        brunch cm_hercules-userdebug
                
                else
                        brunch cm_hercules-userdebug
                fi
                ;;
        quincyatt)
                ./hercskytools/cm10.1-apply.sh
                . build/envsetup.sh
                ./vendor/cm/get-prebuilts
		if [ "$ADDITIONAL" -eq "eng" ]
                then
                        brunch cm_quincyatt-eng
                
                elif [ "$ADDITIONAL" -eq "userdebug" ]
		then
                        brunch cm_quincyatt-userdebug
                
                else
                        brunch cm_quincyatt-userdebug
                fi
                ;;
        *)
                echo -e "Usage: $0 DEVICE ADDITIONAL"
		echo -e "ADDITONAL: eng, userdebug"
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

