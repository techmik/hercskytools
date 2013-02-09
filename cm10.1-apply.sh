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
#   - Camcorder preview is very low resolution
#   - Whole device encryption does not work
#   - Wifi hotspot does not work
#   - Recovery external_sd is not available
#   - Recovery "reboot system" and "reboot recovery" simply turns power off
# Preview2.1
#   - fix: /external_sd is not available
# Preview2
#   - fix: brightness slider did not take affect until lock/unlock of device
#   - fix: CPU spends most of time at 1512 and 384 && battery life is short (cyanogen tuned the powerHAL)
#   - Clean up of the msm8660-common device tree
# Preview1
#   - first CM10.1 release

################ Apply Common Patches Below ####################

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "msm8660: create legacy symlink at /external_sd"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_device_samsung_msm8660-common refs/changes/95/31695/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto vendor/cm
cdv vendor/cm
echo "apns: add 'phone' APN for AT&T"
git fetch http://review.cyanogenmod.org/CyanogenMod/android_vendor_cm refs/changes/87/31087/3 && git cherry-pick FETCH_HEAD
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


################ Apply Quincyatt-Specific Patches Below ####################

#if [ -e device/samsung/quincyatt ]; then
#repo start auto device/samsung/quincyatt
#cdv device/samsung/quincyatt
#cdb
#fi


##### SUCCESS ####
SUCCESS=true
exit 0

