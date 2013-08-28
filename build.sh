#!/bin/bash

set -e

COMMAND="$1"
ADDITIONAL="$2"

# Starting timer
START=$(date +%s)

# Device specific settings
    case "$COMMAND" in
        clean)
                make clobber
                make clean
                cd kernel/samsung/msm8660-common
                make mrproper
                cd ../../../
                exit
                ;;

        prepare)
		        (repo abandon auto && repo sync -j8) ||
		        repo sync -j8
		        exit
                ;;

        exhilarate-10.2)
                ./hercskytools/cm-10.2-celox.sh $COMMAND
                . build/envsetup.sh
                export CCACHE_BASEDIR="$HOME"
                ./vendor/cm/get-prebuilts
                if [ "$ADDITIONAL" = "eng" ]
                then
                        brunch cm_exhilarate-eng

                elif [ "$ADDITIONAL" = "userdebug" ]
                then
                        brunch cm_exhilarate-userdebug

                else
                        brunch cm_exhilarate-userdebug
                fi
                ;;

        skyrocket-10.1)
                ./hercskytools/cm-10.1-celox.sh $COMMAND
                . build/envsetup.sh
		export CCACHE_BASEDIR="$HOME"
                ./vendor/cm/get-prebuilts
		if [ "$ADDITIONAL" = "eng" ]
		then
    			brunch cm_skyrocket-eng

		elif [ "$ADDITIONAL" = "userdebug" ]
		then
    			brunch cm_skyrocket-userdebug

		else
    			brunch cm_skyrocket-userdebug
		fi
                ;;

        skyrocket-10.2)
                ./hercskytools/cm-10.2-celox.sh $COMMAND
                . build/envsetup.sh
		export CCACHE_BASEDIR="$HOME"
                ./vendor/cm/get-prebuilts
		if [ "$ADDITIONAL" = "eng" ]
		then
    			brunch cm_skyrocket-eng

		elif [ "$ADDITIONAL" = "userdebug" ]
		then
    			brunch cm_skyrocket-userdebug

		else
    			brunch cm_skyrocket-userdebug
		fi
                ;;

        hercules-10.1)
                ./hercskytools/cm-10.1-celox.sh $COMMAND
                . build/envsetup.sh
		export CCACHE_BASEDIR="$HOME"
                ./vendor/cm/get-prebuilts
                if [ "$ADDITIONAL" = "eng" ]
                then
                        brunch cm_hercules-eng

                elif [ "$ADDITIONAL" = "userdebug" ]
		then
                        brunch cm_hercules-userdebug

                else
                        brunch cm_hercules-userdebug
                fi
                ;;

        hercules-10.2)
                ./hercskytools/cm-10.2-celox.sh $COMMAND
                . build/envsetup.sh
		export CCACHE_BASEDIR="$HOME"
                ./vendor/cm/get-prebuilts
                if [ "$ADDITIONAL" = "eng" ]
                then
                        brunch cm_hercules-eng

                elif [ "$ADDITIONAL" = "userdebug" ]
		then
                        brunch cm_hercules-userdebug

                else
                        brunch cm_hercules-userdebug
                fi
                ;;

        quincyatt-10.1)
                ./hercskytools/cm-10.1-celox.sh $COMMAND
                . build/envsetup.sh
		export CCACHE_BASEDIR="$HOME"
                ./vendor/cm/get-prebuilts
		if [ "$ADDITIONAL" = "eng" ]
                then
                        brunch cm_quincyatt-eng

                elif [ "$ADDITIONAL" = "userdebug" ]
		then
                        brunch cm_quincyatt-userdebug

                else
                        brunch cm_quincyatt-userdebug
                fi
                ;;

        quincyatt-10.2)
                ./hercskytools/cm-10.2-celox.sh $COMMAND
                . build/envsetup.sh
		export CCACHE_BASEDIR="$HOME"
                ./vendor/cm/get-prebuilts
		if [ "$ADDITIONAL" = "eng" ]
                then
                        brunch cm_quincyatt-eng

                elif [ "$ADDITIONAL" = "userdebug" ]
		then
                        brunch cm_quincyatt-userdebug

                else
                        brunch cm_quincyatt-userdebug
                fi
                ;;
        *)
                echo -e "Usage: $0 DEVICE-BRANCH ADDITIONAL"
		echo -e "ADDITONAL: eng, userdebug (default)"
                echo -e "Example: ./build.sh skyrocket-10.1 eng"
                echo -e "Supported Devices: skyrocket, hercules, quincyatt, exhilarate"
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

