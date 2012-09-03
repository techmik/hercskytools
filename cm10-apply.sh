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

repo start auto kernel/samsung/msm8660-common
cdv kernel/samsung/msm8660-common
echo "### Revert \"video: msm: Add user-defined backlight scaling\""
git fetch http://review.cyanogenmod.com/CyanogenMod/android_kernel_samsung_msm8660-common refs/changes/77/22377/1 && git cherry-pick FETCH_HEAD
#echo "### LCD: ld9040: increase the delay in powerup"
#git fetch http://review.cyanogenmod.com/CyanogenMod/android_kernel_samsung_msm8660-common refs/changes/72/22272/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### msm8660: remove mdp_bl_scale_data from header file to match kernel"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/78/22378/1 && git cherry-pick FETCH_HEAD
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

