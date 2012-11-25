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

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### msm8660: define TARGET_ARCH as required by 4.2"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_msm8660-common refs/changes/58/27058/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: disable overlays broken/obsolete in 4.2"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_msm8660-common refs/changes/60/27060/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto device/samsung/celox-common
cdv device/samsung/celox-common
echo "### celox-common BoardConfigCommon.mk: New syntax for specifying ramdisk offset."
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_celox-common refs/changes/57/27057/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto hardware/libhardware
cdv hardware/libhardware
echo "### remove non-existent AUDIO_CHANNEL_IN_5POINT1 and change to only other audio input AUDIO_CHANNEL_IN_ALL"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_hardware_libhardware refs/changes/56/26756/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto system/core
cdv system/core
echo "### fix compile errors by defining AUDIO_FORMAT_QCELP & AUDIO_FORMAT_EVRC"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_system_core refs/changes/55/26755/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/base
cdv frameworks/base
echo "### implement noise suppression for phone calls (1/2)"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/55/27055/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto packages/apps/Phone
cdv packages/apps/Phone
echo "### Phone: implement noise suppression for phone calls (2/2)"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_Phone refs/changes/56/27056/1 && git cherry-pick FETCH_HEAD
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

