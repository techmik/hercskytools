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


# Changelog

# Known issues
#   - Recovery external_sd is not available
#   - Recovery "reboot system" and "reboot recovery" simply turns power off

################ Apply Common Patches Below ####################

repo start auto device/samsung/celox-common
cdv device/samsung/celox-common
echo "celox-common: Enable thermald"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_celox-common refs/changes/94/35694/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "msm8660: Add GPS HAL"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_msm8660-common refs/changes/91/35691/3 && git cherry-pick FETCH_HEAD
echo "msm8660: Update for new kernel and userspace"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_msm8660-common refs/changes/92/35692/3 && git cherry-pick FETCH_HEAD
cdb

#repo start auto device/samsung/qcom-common
#cdv device/samsung/qcom-common
#cdb


################ Apply Hercules-Specific Patches Below ####################

if [ -e device/samsung/hercules ]; then
repo start auto device/samsung/hercules
cdv device/samsung/hercules
echo "hercules: Update firmware and board name"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_hercules refs/changes/96/35696/1 && git cherry-pick FETCH_HEAD
cdb
fi


################ Apply Skyrocket-Specific Patches Below ####################

if [ -e device/samsung/skyrocket ]; then
repo start auto device/samsung/skyrocket
cdv device/samsung/skyrocket
echo "skyrocket: Update firmware and board name"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_skyrocket refs/changes/95/35695/1 && git cherry-pick FETCH_HEAD
cdb
fi


################ Apply Quincyatt-Specific Patches Below ####################

#if [ -e device/samsung/quincyatt ]; then
#repo start auto device/samsung/quincyatt
#cdv device/samsung/quincyatt
#cdb
#fi


##### SUCCESS ####
SUCCESS=true
exit 0

