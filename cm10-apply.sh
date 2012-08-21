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

repo start auto frameworks/base
cdv frameworks/base
echo "### SamsungQualcommUiccRil: hack to prevent SIM unlock popup"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_frameworks_base refs/changes/19/21719/1 && git cherry-pick FETCH_HEAD
cdb

repo start auto system/core
cdv system/core
echo "### diag: Remove world read/write permissions from /dev/diag"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_system_core refs/changes/93/21793/2 && git cherry-pick FETCH_HEAD
cdb

repo start auto vendor/cm
cdv vendor/cm
echo "### cm: New boot animation from Cameron Behzadpour"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_vendor_cm refs/changes/99/21799/1 && git cherry-pick FETCH_HEAD
cdb


################ Apply Hercules-Specific Patches Below ####################

if [ -e device/samsung/hercules ]; then
repo start auto device/samsung/hercules
cdv device/samsung/hercules
echo "### hercules: remove deprecated qcomuiccstack property"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/28/21728/1 && git cherry-pick FETCH_HEAD
echo "### hercules: mount debugfs to fix Trace"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/60/21760/1 && git cherry-pick FETCH_HEAD
echo "### hercules: Use new qcom_diag group for RIL"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/09/21809/1 && git cherry-pick FETCH_HEAD
echo "### hercules: use new square boot animation"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_hercules refs/changes/10/21810/1 && git cherry-pick FETCH_HEAD
cdb
fi


################ Apply Skyrocket-Specific Patches Below ####################

if [ -e device/samsung/skyrocket ]; then
repo start auto device/samsung/skyrocket
cdv device/samsung/skyrocket
echo "### skyrocket: remove deprecated qcomuiccstack property"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/30/21730/1 && git cherry-pick FETCH_HEAD
echo "### skyrocket: mount debugfs to fix Trace"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/61/21761/1 && git cherry-pick FETCH_HEAD
echo "### skyrocket: Use new qcom_diag group for RIL"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/11/21811/1 && git cherry-pick FETCH_HEAD
echo "### skyrocket: use new square boot animation"
git fetch http://review.cyanogenmod.com/CyanogenMod/android_device_samsung_skyrocket refs/changes/12/21812/1 && git cherry-pick FETCH_HEAD
cdb
fi


##### SUCCESS ####
SUCCESS=true
exit 0

