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

repo start auto vendor/cm
cdv vendor/cm
echo "### cm: New boot animation from Cameron Behzadpour"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_vendor_cm refs/changes/99/21799/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto device/samsung/msm8660-common
cdv device/samsung/msm8660-common
echo "### msm8660: add PowerHAL, ported from d2"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/93/21893/2 && git cherry-pick FETCH_HEAD
echo "### msm8660: use default toolchain for kernel compile"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/32/21932/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: update headers to match kernel"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/33/21933/1 && git cherry-pick FETCH_HEAD
echo "### msm8660: Enable video preview workarounds"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_msm8660-common refs/changes/50/21950/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto packages/apps/Camera
cdv packages/apps/Camera
echo "### CAMERA FIXES"
git pull http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_Camera refs/changes/55/21955/1
cdb

repo start auto packages/apps/Mms
cdv packages/apps/Mms
echo "### SmsReceiverService: Stop only if there's no outstanding SMSes being sent."
git fetch http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_Mms refs/changes/86/21886/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto frameworks/base
cdv frameworks/base
echo "### Add option for switching between UMS and MTP/PTP mode. (1/2)"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_base refs/changes/17/21117/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto packages/apps/Settings
cdv packages/apps/Settings
echo "### Add option for switching between UMS and MTP/PTP mode. (2/2)"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_packages_apps_Settings refs/changes/15/21115/1 && git cherry-pick FETCH_HEAD
cdb

################ Apply Hercules-Specific Patches Below ####################

if [ -e device/samsung/hercules ]; then
repo start auto device/samsung/hercules
cdv device/samsung/hercules
echo "### hercules: use new square boot animation"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/10/21810/1 && git cherry-pick FETCH_HEAD
echo "### hercules: clean up system.prop"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/36/21936/1 && git cherry-pick FETCH_HEAD
cdb
fi

################ Apply Skyrocket-Specific Patches Below ####################

if [ -e device/samsung/skyrocket ]; then
repo start auto device/samsung/skyrocket
cdv device/samsung/skyrocket
echo "### skyrocket: use new square boot animation"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/12/21812/1 && git cherry-pick FETCH_HEAD
echo "### skyrocket: clean up system.prop"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/39/21939/1 && git cherry-pick FETCH_HEAD
cdb
fi


##### SUCCESS ####
SUCCESS=true
exit 0

