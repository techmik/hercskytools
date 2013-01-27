#!/bin/bash

unset SUCCESS
on_exit() {
  if [ -z "$SUCCESS" ]; then
    echo "ERROR: $0 failed.  Please fix the above error."
    exit 1
  else
    echo "SUCCESS: $0 has completed."
    exit 0
  fi
}
trap on_exit EXIT

http_patch() {
  PATCHNAME=$(basename $1)
  curl -L -o $PATCHNAME -O -L $1
  cat $PATCHNAME |patch -p1
  rm $PATCHNAME
}

# Change directory verbose
cdv() {
  echo
  echo "*****************************"
  echo "Current Directory: $1"
  echo "*****************************"
  cd $BASEDIR/$1
}

# Change back to base directory
cdb() {
  cd $BASEDIR
}

# Sanity check
if [ -d ../.repo ]; then
  cd ..
fi
if [ ! -d .repo ]; then
  echo "ERROR: Must run this script from the base of the repo."
  SUCCESS=true
  exit 255
fi

# Save Base Directory
BASEDIR=$(pwd)

# Abandon auto topic branch
repo abandon auto
set -e


################ Apply Common Patches Below ####################

repo start auto build
cdv build
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/26/30226/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware
cdv hardware/libhardware
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_libhardware refs/changes/27/30227/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto development
cdv development
git fetch http://review.cyanogenmod.org/CyanogenMod/android_development refs/changes/63/30363/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/base
cdv frameworks/base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/90/30390/1 && git cherry-pick FETCH_HEAD
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/50/30350/3 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/native
cdv frameworks/native
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/91/30391/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/av
cdv frameworks/av
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_av refs/changes/23/30223/4 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware_legacy
cdv hardware/libhardware_legacy
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_libhardware_legacy refs/changes/72/30972/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto system/core
cdv system/core
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_core refs/changes/25/30225/7 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/qcom/audio
cdv hardware/qcom/audio
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_qcom_audio refs/changes/63/31063/3 && git cherry-pick FETCH_HEAD
cdb

repo start auto device/samsung/celox-common
cdv device/samsung/celox-common
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_celox-common refs/changes/80/31080/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_msm8660-common refs/changes/81/31081/1 && git cherry-pick FETCH_HEAD
cdb


################ Apply Hercules-Specific Patches Below ####################

#if [ -e device/samsung/hercules ]; then
#repo start auto device/samsung/hercules
#cdv device/samsung/hercules
#cdb
#fi


################ Apply Skyrocket-Specific Patches Below ####################

#if [ -e device/samsung/skyrocket ]; then
#repo start auto device/samsung/skyrocket
#cdv device/samsung/skyrocket
#cdb
#fi


##### SUCCESS ####
SUCCESS=true
exit 0

