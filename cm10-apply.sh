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

repo start auto system/core
cdv system/core
echo "### libpixelflinger: Build NEON optimized routine per target configuration"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_system_core refs/changes/18/22218/1 && git cherry-pick FETCH_HEAD
echo "### libpixelflinger: Add ARM NEON optimized scanline_t32cb16"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_system_core refs/changes/19/22219/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/base
cdv frameworks/base
echo "### SamsungQualcomm RILs: throttle multiple outstanding SEND_SMS requests"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_base refs/changes/56/22356/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto kernel/samsung/msm8660-common
cdv kernel/samsung/msm8660-common
echo "### fix compiling on Mac with non-GZIP kernel compressions"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_kernel_samsung_msm8660-common refs/changes/56/22456/1 && git cherry-pick FETCH_HEAD
cdb

#repo start auto external/freetype
#cdv external/freetype
#echo "### Freetype patches"
#git pull http://review.cyanogenmod.com/CyanogenMod/android_external_freetype refs/changes/87/22387/1
#cdb


################ Apply Hercules-Specific Patches Below ####################

if [ -e device/samsung/hercules ]; then
repo start auto device/samsung/hercules
cdv device/samsung/hercules
echo "### hercules: allow SMS > 160 to use multipart"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/06/22406/1 && git cherry-pick FETCH_HEAD
cdb
fi

################ Apply Skyrocket-Specific Patches Below ####################

if [ -e device/samsung/skyrocket ]; then
repo start auto device/samsung/skyrocket
cdv device/samsung/skyrocket
echo "### skyrocket: allow SMS > 160 to use multipart"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/55/22355/1 && git cherry-pick FETCH_HEAD
cdb
fi


##### SUCCESS ####
SUCCESS=true
exit 0

