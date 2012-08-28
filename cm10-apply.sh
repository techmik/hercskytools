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

repo start auto packages/apps/Settings
cdv packages/apps/Settings
echo "### Add option for switching between UMS and MTP/PTP mode. (2/2)"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_Settings refs/changes/15/21115/4 && git cherry-pick FETCH_HEAD
cdb

repo start auto system/core
cdv system/core
echo "### libpixelflinger: Build NEON optimized routine per target configuration"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_system_core refs/changes/18/22218/1 && git cherry-pick FETCH_HEAD
echo "### libpixelflinger: Add ARM NEON optimized scanline_t32cb16"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_system_core refs/changes/19/22219/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto kernel/samsung/msm8660-common
cdv kernel/samsung/msm8660-common
echo "### LCD: ld9040: increase the delay in powerup"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_kernel_samsung_msm8660-common refs/changes/72/22272/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: update skyrocket defconfig with latest from quincy"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_kernel_samsung_msm8660-common refs/changes/25/22325/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: update hercules defconfig"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_kernel_samsung_msm8660-common refs/changes/36/22336/1 && git checkout FETCH_HEAD
cdb


################ Apply Hercules-Specific Patches Below ####################

if [ -e device/samsung/hercules ]; then
repo start auto device/samsung/hercules
cdv device/samsung/hercules
echo "### hercules: remove BOARD_HAS_SAMSUNG_VOLUME_BUG as it is unneeded"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/74/22274/1 && git cherry-pick FETCH_HEAD
cdb
fi

################ Apply Skyrocket-Specific Patches Below ####################

if [ -e device/samsung/skyrocket ]; then
repo start auto device/samsung/skyrocket
cdv device/samsung/skyrocket
echo "### skyrocket: clean up system properties and BoardConfig"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/39/21939/2 && git cherry-pick FETCH_HEAD
cdb
fi


##### SUCCESS ####
SUCCESS=true
exit 0

